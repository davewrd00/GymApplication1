//
//  MenuBarViewCell.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class MenuBarViewCell: UICollectionViewCell {
  
  
  var dateAndTimeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont(name: "Avenir", size: 10)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    addSubview(dateAndTimeLabel)
    
    dateAndTimeLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
