//
//  SettingsCell.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
      nameLabel.textColor = isHighlighted ? UIColor.white: UIColor.black
      iconImageView.tintColor = isHighlighted ? UIColor.white: UIColor.darkGray
    }
  }
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.name.rawValue
      
      if let imageName = setting?.imageName {
        iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        iconImageView.tintColor = .darkGray
      }
    }
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Setting"
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let iconImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "settings")
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(nameLabel)
    addSubview(iconImageView)
    
    addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
    addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
    
    addConstraintsWithFormat(format: "V:|[v0(30)]", views: iconImageView)
    
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
