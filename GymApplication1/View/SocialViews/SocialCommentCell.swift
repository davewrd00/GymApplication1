//
//  SocialCommentCell.swift
//  GymApplication1
//
//  Created by David on 28/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class SocialCommentCell: UICollectionViewCell {
  
  var comment: Comment? {
    didSet {
      guard let comment = comment else { return }
      
      let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
      
      attributedText.append(NSMutableAttributedString(string: " " + comment.text, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
      
      textView.attributedText = attributedText
      userProfileImageView.loadImage(urlString: comment.user.profileImageUrl)
    }
  }
  
  let textView: UITextView = {
    let tv = UITextView()
    tv.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    tv.isScrollEnabled = false
    //tv.backgroundColor = .blue
    return tv
  }()
  
  let userProfileImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    //iv.backgroundColor = .yellow
    return iv
  }()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    
    addSubview(textView)
    addSubview(userProfileImageView)
    
    userProfileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    userProfileImageView.layer.cornerRadius = 50 / 2
    userProfileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    textView.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    
  }
    
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
