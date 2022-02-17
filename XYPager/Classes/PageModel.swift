//
//  File.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//

public struct PageModel<K, V> {
    public init(data: [V]?, nextKey: K?) {
        self.data = data
        self.nextKey = nextKey
    }
    
    let data: [V]?
    let nextKey: K?
}
