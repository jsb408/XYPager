//
//  DataCell.swift
//  XYPager_Example
//
//  Created by 장수빈 on 2022/02/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dataLabel = UILabel()
    
    private func setView() {
        contentView.addSubview(dataLabel)
        dataLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setData(number: Int) {
        dataLabel.text = "\(number)"
    }
}

class DataCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dataLabel = UILabel()
    
    private func setView() {
        contentView.addSubview(dataLabel)
        dataLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setData(number: Int) {
        dataLabel.text = "\(number)"
    }
}
