//
//  ProfileHeaderCollectionReusableView.swift
//  Twitter-Clone
//
//  Created by rabie houssaini on 30/8/2023.
//

import UIKit

protocol ProfileHeaderDelegate : class {
   func handleDismissProfile()
    func handleEditprofileFollow(_ header: ProfileHeader)
    func didSelect(filter : profileFilterOptions)
}

class ProfileHeader: UICollectionReusableView {
    // MARK: Proprties
    
    var user : User? {
        didSet{
            configure()
        }
    }
    
    
    weak var delegate : ProfileHeaderDelegate?
    private let filterBar  = ProfileFilter()
    private lazy var containerView : UIView = {
        let cv  = UIView()
        cv.backgroundColor = .twitterBlue
        cv.addSubview(backButton)
        backButton.setDimensions(width: 30, height: 30)
        backButton.anchor(top: cv.topAnchor,left: cv.leftAnchor,paddingTop: 42, paddingLeft: 16)
        return cv
    }()
    
    private lazy var backButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return btn
    }()
    
    private lazy var profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        
        iv.setDimensions(width: 80, height: 80)
        iv.layer.cornerRadius = 80 / 2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 5
        
        return iv
    }()
    
     lazy var editProfileFollowButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Loading", for: .normal)
        btn.layer.borderColor = UIColor.twitterBlue.cgColor
        btn.layer.borderWidth = 1.25
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        btn.setDimensions(width: 100, height: 36)
        btn.layer.cornerRadius = 36 / 2
        return btn
        
    }()
    private let fullNameLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Rabie houssaini"
        return label
    }()
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "Rabi3Hs"
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.text = "this is my awsome twitter clone app which is my first ios project using UIKit , i which to going more and more to be master ios developer"
        label.textColor = .black
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
  
    
    private let followingLabel : UILabel = {
        let label = UILabel()
        label.text = "0 Following"

        let followTap = UIGestureRecognizer(target: ProfileHeader.self, action: #selector(handleFollowingTaped))
        label.addGestureRecognizer(followTap)
        return label
    }()
    private let followersLabel : UILabel = {
        let label = UILabel()
        label.text = "2 Followers"
        let followTap = UIGestureRecognizer(target: ProfileHeader.self, action: #selector(handleFollowersTaped))
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // backgroundColor = .red
        filterBar.delegate = self
        

     configureUI()

        
    
    }
    
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Selectors
    @objc func handleBack(){
        delegate?.handleDismissProfile()
    }
    @objc func handleEditProfileFollow(){
        delegate?.handleEditprofileFollow(self)
    }
    
    @objc func handleFollowingTaped(){
        
    }
    @objc func handleFollowersTaped(){
        
    }
    // MARK: API

    // MARK: Helpers
    func configureUI(){
        addSubview(containerView)
        containerView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,height: 108)
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor,left: leftAnchor,paddingTop: -24, paddingLeft: 8)
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(
            top: containerView.bottomAnchor, right:  rightAnchor , paddingTop: 12 , paddingRight: 12)
        
        
        let infoStack = UIStackView(arrangedSubviews: [fullNameLabel , userNameLabel , bioLabel])
        infoStack.axis = .vertical
        infoStack.distribution = .fillProportionally
        infoStack.spacing = 4
        addSubview(infoStack)
        infoStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor , right: rightAnchor , paddingTop: 8 , paddingLeft: 12 , paddingRight: 12)
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,height: 50)
        
      
        let followStack = UIStackView(arrangedSubviews: [followingLabel , followersLabel])
        followStack.axis = .horizontal
        followStack.distribution = .fillEqually
        followStack.spacing = 8
        addSubview(followStack)
        followStack.anchor(top: infoStack.bottomAnchor, left: leftAnchor , paddingTop: 8 , paddingLeft: 12)
    }
    
    func configure(){
        guard let user = user else {return}
        let viewModel = ProfileHeaderViewModel(user: user)
        
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        fullNameLabel.text = viewModel.fullNameLabel
        userNameLabel.text = viewModel.userNameLabel
        
        
    }

}

extension ProfileHeader : ProfileFilterDelegate{
    func animateUnderlineSelection(_ view: ProfileFilter, didSelect index: Int) {
        
        guard let filter = profileFilterOptions(rawValue: index) else {return}
        
        delegate?.didSelect(filter: filter)
      /*  guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else  {
            return
        }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.profileUnderlineView.frame.origin.x = xPosition
        }*/
        
        
    }
    
    
}
