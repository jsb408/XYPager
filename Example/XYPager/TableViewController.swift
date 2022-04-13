//
//  TableViewController.swift
//  XYPager_Example
//
//  Created by 장수빈 on 2022/04/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa
import XYPager

class TableViewController: UIViewController {
    private let pager = NumberPager(pageSize: 30)
    private let pagingTableView = UIPagingTableView<Int, Int>()
    private let refreshControl = UIRefreshControl()
    
    private let refreshButton = UIButton(type: .system)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        pagingTableView.refreshControl = refreshControl
        
        view.addSubview(pagingTableView)
        pagingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        pagingTableView.register(DataCell.self, forCellReuseIdentifier: "DataCell")
        pagingTableView.setPager(pager: pager)
        pagingTableView.isShowIndicator = true
        
        pager.data
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: pagingTableView.rx.items(cellIdentifier: "DataCell", cellType: DataCell.self)) { (index: Int, element: Int, cell: DataCell) in
                self.refreshControl.endRefreshing()
                cell.setData(number: element)
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).asObservable()
            .subscribe(onNext: {
                self.pagingTableView.refresh()
            })
            .disposed(by: disposeBag)
        
        view.addSubview(refreshButton)
        refreshButton.setTitle("새로고침", for: .normal)
        refreshButton.backgroundColor = .red
        refreshButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(pagingTableView)
        }
        refreshButton.rx.tap
            .subscribe(onNext: {
                self.pagingTableView.refresh()
            })
            .disposed(by: disposeBag)
    }
}
