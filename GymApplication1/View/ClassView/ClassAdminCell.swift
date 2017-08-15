//
//  ClassAdminCell.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassAdminCell: UICollectionViewCell {
  
  let classNameLabel = UILabel()
  
  lazy var classImageView: UIImageView = {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    self.classNameLabel.textColor = .white
    self.classNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 36.0)
    iv.addSubview(self.classNameLabel)
    self.classNameLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    self.classNameLabel.centerXAnchor.constraint(equalTo: iv.centerXAnchor).isActive = true
    self.classNameLabel.centerYAnchor.constraint(equalTo: iv.centerYAnchor).isActive = true
    
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(classImageView)
    classImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
