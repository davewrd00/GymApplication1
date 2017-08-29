//
//  ClassDetailInfoTimeView.swift
//  GymApplication1
//
//  Created by David on 28/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassDetailInfoTimeCell: UICollectionViewCell {
  
  let iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.image = UIImage(named: "clock")?.withRenderingMode(.alwaysOriginal)
    return iv
  }()
  
  let timeOfClassLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "45 min"
    lbl.textColor = .black
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    addSubview(iconImageView)
    addSubview(timeOfClassLabel)

    timeOfClassLabel.anchor(top: iconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    timeOfClassLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    iconImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
    iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
 
  
}
