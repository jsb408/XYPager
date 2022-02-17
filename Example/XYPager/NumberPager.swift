//
//  NumberPager.swift
//  XYPager_Example
//
//  Created by 장수빈 on 2022/02/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XYPager

class NumberPager: Pager<Int, Int> {
    override func loadMore() {
        let page = key ?? 0
        let data = getSampleData(key: page, pageSize: pageSize)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addPageData(data: PageModel(
                data: data,
                nextKey: data.count < self.pageSize ? nil : (page + 1)
            ))
        }
    }
}
