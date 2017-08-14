//
//  HomeGoalsProgressCell.swift
//  GymApplication1
//
//  Created by David on 12/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class HomeGoalsCell: UICollectionViewCell {

  let view: UIView = {
    let v = UIView()
    
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOpacity = 0.5
    v.layer.shadowOffset = CGSize(width: -1, height: 1)
    v.layer.shadowRadius = 1
    v.layer.cornerRadius = 3
    v.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    v.layer.shadowColor = UIColor.lightGray.cgColor
    return v
  }()
  
  let levelLabel: UILabel = {
    let lbl = UILabel()
    lbl.attributedText = NSAttributedString(string: "Level: 1", attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir", size: 16), NSAttributedStringKey.foregroundColor: UIColor.black])
    return lbl
  }()
  
  let pointsLabel: UILabel = {
    let label = UILabel()
    label.attributedText = NSAttributedString(string: "Points: 100", attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir", size: 16), NSAttributedStringKey.foregroundColor: UIColor.black])
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    addSubview(view)
    addSubview(levelLabel)
    addSubview(pointsLabel)
    
    view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
    levelLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
    
    pointsLabel.anchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
