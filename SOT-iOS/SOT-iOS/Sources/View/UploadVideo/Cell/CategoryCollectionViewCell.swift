//
//  CategoryCollectionViewCell.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel().then {
        $0.font = UIFont.SOTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    override var isSelected: Bool {
        didSet {
            self.titleLabel.textColor = isSelected ? UIColor.white.withAlphaComponent(1) : UIColor.white.withAlphaComponent(0.5)
            self.contentView.backgroundColor = isSelected ? UIColor.SOTColor.sotPurple.withAlphaComponent(1) : UIColor.SOTColor.sotPurple.withAlphaComponent(0.5)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setData(model: CategoryDataModel) {
        titleLabel.text = model.title
    }
    
    private func setUI() {
        backgroundColor = UIColor.SOTColor.sotPurple.withAlphaComponent(0.5)
        layer.masksToBounds = true
        layer.cornerRadius = 16
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
