//
//  UIPagingTableView.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//

import UIKit
import RxSwift
import RxCocoa

public class UIPagingTableView<K, V>: UITableView, UITableViewDelegate {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var isShowIndicator = false
    
    private var pager: Pager<K, V>? = nil
    private let disposeBag = DisposeBag()
    
    public func setPager(pager: Pager<K, V>) {
        self.pager = pager
        
        self.pager?.isLoading
            .subscribe {
                self.tableFooterView = $0 && self.isShowIndicator ? self.createSpinnerView() : nil
            }
            .disposed(by: disposeBag)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
}
