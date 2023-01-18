//
//  UIPagingTableView.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//

import UIKit
import RxSwift

public class UIPagingTableView<K, V>: UITableView {
    public var isShowIndicator = false
    
    private var pager: Pager<K, V>? = nil
    private let disposeBag = DisposeBag()
    
    public func setPager(pager: Pager<K, V>) {
        self.pager = pager
        
        self.pager?.isLoading
            .drive {
                self.tableFooterView = $0 && self.isShowIndicator ? self.createSpinnerView() : nil
            }
            .disposed(by: disposeBag)
    }
    
    public func checkScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - 100 - scrollView.frame.size.height) {
            pager?.load()
        }
    }
    
    private func createSpinnerView() -> UIView {
        let footerView = UIView()
        footerView.frame.size.height = 100
        footerView.frame.size.width = UIScreen.main.bounds.width
        
        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.center = footerView.center
        spinner.startAnimating()
        
        return footerView
    }
    
    public func refresh() {
        self.pager?.refresh()
    }
}
