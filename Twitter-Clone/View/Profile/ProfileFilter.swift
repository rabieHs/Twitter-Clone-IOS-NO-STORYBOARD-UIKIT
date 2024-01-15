//
//  ProfileFilter.swift
//  Twitter-Clone
//
//  Created by rabie houssaini on 31/8/2023.
//

import UIKit


protocol ProfileFilterDelegate : AnyObject {
    func  animateUnderlineSelection(_ view: ProfileFilter , didSelect index: Int)
}

 let profileReuseIdentifier = "ProfileCellFilter"

class ProfileFilter: UIView {
    
    // MARK: Proprties
    
    weak var delegate : ProfileFilterDelegate?
    
    lazy var collectionView : UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    private let profileUnderlineView : UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    // MARK: Lifecycle
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: profileReuseIdentifier)
        addSubview(collectionView)
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        //fill all the view
        collectionView.addConstraintsToFillView(self)
        
    }
    override func layoutSubviews() {
        addSubview(profileUnderlineView)
        profileUnderlineView.anchor(left: leftAnchor,bottom: bottomAnchor,width: frame.width / 3,height: 2)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors

    // MARK: Helpers
}
extension ProfileFilter : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileFilterOptions.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: profileReuseIdentifier, for: indexPath) as! ProfileFilterCell
        let option = profileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
        
    }
  
}

extension ProfileFilter : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0
          UIView.animate(withDuration: 0.3) {
              self.profileUnderlineView.frame.origin.x = xPosition
          }
        delegate?.animateUnderlineSelection(self, didSelect: indexPath.row)
    }
}

extension ProfileFilter : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
