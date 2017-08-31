//
//  MessageView.swift
//  GymApplication1
//
//  Created by David on 30/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class MessageView: UICollectionViewCell {
  
  var user: User? {
    didSet {
      print("Setting poo")
      self.userName.text = user?.username
      
      guard let imageUrl = user?.profileImageUrl else { return }
      self.userProfileImageView.loadImage(urlString: imageUrl)
      
      
    }
  }
  
  let cellView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: -1, height: 1)
    view.layer.shadowRadius = 1
    view.layer.cornerRadius = 3
    return view
  }()
  
  let userProfileImageView: CustomImageView = {
    let iv = CustomImageView()
    return iv
  }()
  
  let userName: UILabel = {
    let lbl = UILabel()
    lbl.text = "Catherine Evans"
    lbl.font = UIFont(name: "HelveticaNeue-Regular", size: 24)
    return lbl
  }()

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .yellow
    
    addSubview(cellView)
    addSubview(userProfileImageView)
    addSubview(userName)

    userName.anchor(top: userProfileImageView.topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    userProfileImageView.anchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    userProfileImageView.layer.cornerRadius = 50 / 2
    userProfileImageView.layer.masksToBounds = true
    userProfileImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    
    cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
