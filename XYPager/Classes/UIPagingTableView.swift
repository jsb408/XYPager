//
//  UIPagingTableView.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//

import UIKit

public class UIPagingTableView<K, V>: UITableView, UITableViewDelegate {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var pager: Pager<K, V>? = nil
    
    public func setPager(pager: Pager<K, V>) {
        self.pager = pager
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - 100 - scrollView.frame.size.height) {
            pager?.load()
        }
    }
}
