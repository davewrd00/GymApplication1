//
//  ClassCellView.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassCellView: UICollectionViewCell {
  
  var classes: Classes? {
    didSet {
      nameLabel.text = classes?.className
      print("POO \(classes?.className)")
      
    }
  }

  lazy var classProfileImage: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .yellow
    return iv
  }()
  
  let nameLabel: UILabel  = {
    let lbl = UILabel()
    lbl.text = "TEST"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
    return lbl
  }()
  
  let classDescriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Light", size: 13)
    return lbl
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
  
  let timeStampLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    addSubview(cellView)
    addSubview(classProfileImage)
    addSubview(nameLabel)
    addSubview(classDescriptionLabel)
    
    cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
    classProfileImage.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    classProfileImage.layer.cornerRadius = 50 / 2
    classProfileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    nameLabel.anchor(top: classProfileImage.topAnchor, left: classProfileImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    classDescriptionLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
