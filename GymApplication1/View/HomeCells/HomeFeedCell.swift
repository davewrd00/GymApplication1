//
//  HomeFeedCell.swift
//  GymApplication1
//
//  Created by David on 12/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class HomeFeedCell: UICollectionViewCell {
  
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
  
  let userProfileImageView: UIImageView = {
    let iv = UIImageView()
    iv.layer.borderColor = UIColor.black.cgColor
    iv.layer.cornerRadius = 5
    iv.layer.shadowColor = UIColor.black.cgColor
    iv.layer.shadowOpacity = 0.2
    iv.layer.shadowOffset = CGSize(width: 1, height: 1)
    iv.layer.shadowRadius = 1
    iv.backgroundColor = .yellow
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    iv.image = UIImage(named: "catherine")
    return iv
  }()
  
  let userProfileName: UILabel = {
    let lbl = UILabel()
    lbl.text = "davewrd00"
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
    return lbl
  }()
  
  let userFeed: UITextView = {
    let view = UITextView()
    view.backgroundColor = .blue
    view.text = "Howdy there, this is just some text to show some randomshit to see what my textview screen would look like"
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    addSubview(cellView)
    addSubview(userProfileImageView)
    addSubview(userProfileName)
    addSubview(userFeed)
    
    cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
    userProfileImageView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
    
    userProfileName.anchor(top: userProfileImageView.topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 150, height: 0)
    
    userFeed.anchor(top: userProfileName.bottomAnchor, left: userProfileName.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 3, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
