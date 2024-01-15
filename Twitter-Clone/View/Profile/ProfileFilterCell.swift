//
//  ProfileFilterCellCollectionViewCell.swift
//  Twitter-Clone
//
//  Created by rabie houssaini on 31/8/2023.
//

import UIKit


class ProfileFilterCell: UICollectionViewCell {
    var option: profileFilterOptions!{
        didSet{
            titleLabel.text = option.description
        }
    }
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "test"
        return label
    }()
    
    override var isSelected: Bool{
        didSet{
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? UIColor.twitterBlue : UIColor.lightGray

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
