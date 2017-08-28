//
//  AchievementsCell.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class AchievementsCell: UICollectionViewCell {
  
  var achievements: Achievements? {
    didSet {
      achievementNameLabel.text = achievements?.achievementName
    }
  }
  
  var achievementsEarnedNames = [String]() {
    didSet {
      for name in achievementsEarnedNames {
        print("BOOBsssss \(name)")
      }
    }
  }
  
  let imageView: CustomImageView = {
    let iv = CustomImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
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
  
  let achievementNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26.0)
    return lbl
  }()
  
  let achievementDescription: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    lbl.numberOfLines = 0
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(cellView)
    addSubview(imageView)
    addSubview(achievementNameLabel)
    addSubview(achievementDescription)
    
    cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
    imageView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 0, width: 80, height: cellView.frame.height)
    
    achievementNameLabel.anchor(top: cellView.topAnchor, left: imageView.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    achievementDescription.anchor(top: achievementNameLabel.bottomAnchor, left: imageView.rightAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 250, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
