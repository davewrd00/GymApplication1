//
//  MenuCell.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
  
  let dateAndTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "TEST"
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(dateAndTimeLabel)
    addConstraintsWithFormat(format: "H:|[v0(30)]", views: dateAndTimeLabel)
    addConstraintsWithFormat(format: "V:|[v0(30)]", views: dateAndTimeLabel)
    addConstraint(NSLayoutConstraint(item: dateAndTimeLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: dateAndTimeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isHighlighted: Bool {
    didSet {
      dateAndTimeLabel.tintColor = isSelected ? UIColor.white: UIColor.yellow
    }
  }
    
    override var isSelected: Bool {
      didSet {
        dateAndTimeLabel.tintColor = isSelected ? UIColor.white: UIColor.yellow
      
    }
  }
  
  
  
}
