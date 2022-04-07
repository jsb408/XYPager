//
//  ViewController.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa
import XYPager

let sampleData = [Int](0 ... 100)

func getSampleData(key: Int, pageSize: Int) -> [Int] {
    return [] + sampleData[key * pageSize ... min(sampleData.count - 1, (key + 1) * pageSize - 1)]
}

class ViewController: UIViewController {
    private let pager = NumberPager(pageSize: 30)
    private let pagingTableView = UIPagingTableView<Int, Int>()
    private let refreshControl = UIRefreshControl()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}
