//
//  ViewController.swift
//  XYPager
//
//  Created by 장수빈 on 2022/02/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

let sampleData = [Int](0 ... 1000)

func getSampleData(key: Int, pageSize: Int) -> [Int] {
    return [] + sampleData[key * pageSize ... min(sampleData.count - 1, (key + 1) * pageSize - 1)]
}

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let tableViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TableView", for: .normal)
        
        return button
    }()
    
    private let collectionViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CollectionView", for: .normal)
        
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        
        return stack
    }()
    
    override func viewDidLoad() {
        setView()
    }
    
    private func setView() {
        setStackView()
        setButtons()
    }
    
    private func setStackView() {
        buttonsStackView.addArrangedSubview(tableViewButton)
        buttonsStackView.addArrangedSubview(collectionViewButton)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setButtons() {
        tableViewButton.rx.tap
            .subscribe(
                onNext: {
                    let vc = TableViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    self.present(vc, animated: true)
                }
            )
            .disposed(by: disposeBag)
        
        collectionViewButton.rx.tap
            .subscribe(
                onNext: {
                    let vc = CollectionViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    self.present(vc, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
}
