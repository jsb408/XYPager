//
//  CollectionViewController.swift
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

class CollectionViewController: UIViewController {
    private let pager = NumberPager(pageSize: 30)
    private let pagingCollectionView: UIPagingCollectionView<Int, Int> = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        
        let collectionView = UIPagingCollectionView<Int, Int>(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = false
        return collectionView
    }()
    private let refreshControl = UIRefreshControl()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        pagingCollectionView.refreshControl = refreshControl
        
        view.addSubview(pagingCollectionView)
        pagingCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        pagingCollectionView.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: "DataCell")
        pagingCollectionView.setPager(pager: pager)
        
        pager.data
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: pagingCollectionView.rx.items(cellIdentifier: "DataCell", cellType: DataCollectionViewCell.self)) { (index: Int, element: Int, cell: DataCollectionViewCell) in
                self.refreshControl.endRefreshing()
                cell.setData(number: element)
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).asObservable()
            .subscribe(onNext: {
                self.pagingCollectionView.refresh()
            })
            .disposed(by: disposeBag)
    }
}
