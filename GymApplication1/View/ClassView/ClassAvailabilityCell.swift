//
//  ClassAvailabilityCell.swift
//  GymApplication1
//
//  Created by David on 28/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassAvailabilityCell: UICollectionViewCell {
  
  let classAvailabilityLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "22 available"
    lbl.numberOfLines = 0
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(classAvailabilityLabel)
    
    classAvailabilityLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    classAvailabilityLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    classAvailabilityLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
