//
//  Pager.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//

import RxSwift
import RxRelay

open class Pager<K, V> {
    public init(pageSize: Int) {
        self.pageSize = pageSize
        
        self.pageData
            .subscribe(
                onNext: {
                    self._data.accept((self._data.value ?? []) + ($0.data ?? []))
                    self.updateKey(nextKey: $0.nextKey)
                    self.isLoading = false
                }
            )
            .disposed(by: disposeBag)
        
        self.load()
    }
    
    public let pageSize: Int
    
    public var key: K?
    
    private var isLoading: Bool = false
    
    private let _data = BehaviorRelay<[V]?>(value: nil)
    public var data: Observable<[V]> {
        _data.map { $0 ?? [] }.asObservable()
    }
    
    private let pageData = PublishRelay<PageModel<K, V>>()
    private let disposeBag = DisposeBag()
    
    func load() {
        guard (key != nil || _data.value == nil), !isLoading else { return }
        
        self.isLoading = true
        loadMore()
    }
    
    open func loadMore() {
        preconditionFailure("This method must be overridden")
    }
    
    private func updateKey(nextKey: K?) {
        key = nextKey
    }
    
    public func addPageData(data: PageModel<K, V>) {
        self.pageData.accept(data)
    }
}