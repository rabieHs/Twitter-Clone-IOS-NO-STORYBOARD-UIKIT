//
//  TweetCellCollectionViewCell.swift
//  Twitter-Clone
//
//  Created by rabie houssaini on 29/8/2023.
//

import UIKit

class TweetCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
