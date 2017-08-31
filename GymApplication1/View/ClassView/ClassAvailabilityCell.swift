//
//  ClassAvailabilityCell.swift
//  GymApplication1
//
//  Created by David on 28/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassAvailabilityCell: UICollectionViewCell {
  
  let iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.image = UIImage(named: "spaces")?.withRenderingMode(.alwaysOriginal)
    return iv
  }()
  
  let classAvailabilityLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "22 available"
    lbl.numberOfLines = 0
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(iconImageView)
    addSubview(classAvailabilityLabel)
    
    iconImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
    iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    
    classAvailabilityLabel.anchor(top: iconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    classAvailabilityLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
