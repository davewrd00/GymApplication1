//
//  SocialFeedCell.swift
//  GymApplication1
//
//  Created by David on 23/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

protocol SocialFeedCellDelegate {
  func didTapComment(post: Post)
}

class SocialFeedCell: UICollectionViewCell {

  var delegate: SocialFeedCellDelegate?
  
  var post: Post? {
    didSet {
      print("Setting post!")
      
      guard let postImageUrl = post?.imageUrl else { return }
      
      photoImageView.loadImage(urlString: postImageUrl)
      userNameLabel.text = post?.user.username
      captionLabel.text = post?.caption
      
      guard let profileImageUrl = post?.user.profileImageUrl else { return }
      userProfileImageView.loadImage(urlString: profileImageUrl)
    }
  }
  
  let photoImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let userProfileImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let userNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Username"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    return lbl
  }()
  
  lazy var commentButton: UIButton = {
    let btn = UIButton()
    btn.setImage(#imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), for: .normal)
    btn.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
    return btn
  }()
  
  let captionLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.font = UIFont(name: "HelveticaNeue-Normal", size: 14)
    lbl.text = "Just got my first medal today! Woohooo!!! Onto the next one!"
    return lbl
  }()
  
  @objc func handleComment() {
    print("handling this comment")
    guard let post = self.post else { return }
    delegate?.didTapComment(post: post)
    print("POOOO \(post.caption)")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(userProfileImageView)
    addSubview(userNameLabel)
    addSubview(photoImageView)
    addSubview(captionLabel)
    addSubview(commentButton)
    
    commentButton.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: captionLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    
    captionLabel.anchor(top: commentButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    
    userNameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    photoImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    
    userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
    userProfileImageView.layer.cornerRadius = 40 / 2
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  
}
