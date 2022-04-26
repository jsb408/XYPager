//
//  UIPagingCollectionView.swift
//  XYPager
//
//  Created by 장수빈 on 2022/04/13.
//

import UIKit
import RxSwift

public class UIPagingCollectionView<K, V>: UICollectionView {
    private var pager: Pager<K, V>? = nil
    private let disposeBag = DisposeBag()
    
    public func setPager(pager: Pager<K, V>) {
        self.pager = pager
    }
    
    public func checkScroll(_ scrollView: UIScrollView) {
        if (self.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .horizontal
        ? scrollView.contentOffset.x > (scrollView.contentSize.width - 100 - scrollView.frame.size.width)
        : scrollView.contentOffset.y > (scrollView.contentSize.height - 100 - scrollView.frame.size.height) {
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
