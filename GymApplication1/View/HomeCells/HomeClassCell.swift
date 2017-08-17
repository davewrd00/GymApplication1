//
//  HomeClassCell.swift
//  GymApplication1
//
//  Created by David on 12/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import UICircularProgressRing

class HomeClassCell: UICollectionViewCell {
  
  let view: UIView = {
    let v = UIView()
    v.layer.cornerRadius = 4
    v.backgroundColor = .white
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOpacity = 0.5
    v.layer.shadowOffset = CGSize(width: -1, height: 1)
    v.layer.shadowRadius = 1
    v.layer.cornerRadius = 3
    
    let classLabel = UILabel()
    classLabel.text = "Body Pump"
    classLabel.font = UIFont.boldSystemFont(ofSize: 16)
    v.addSubview(classLabel)
    classLabel.translatesAutoresizingMaskIntoConstraints = false
    classLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    classLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
    classLabel.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 10).isActive = true
    classLabel.topAnchor.constraint(equalTo: v.topAnchor, constant: 10).isActive = true
    
    let dateAndTimeLabel = UILabel()
    dateAndTimeLabel.text = "Tuesday 23rd March 2017"
    dateAndTimeLabel.font = UIFont.boldSystemFont(ofSize: 14)
    v.addSubview(dateAndTimeLabel)
    dateAndTimeLabel.numberOfLines = 0
    dateAndTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    dateAndTimeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    dateAndTimeLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
    dateAndTimeLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 10).isActive = true
    dateAndTimeLabel.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 10).isActive = true
    return v
  }()
  
  let profileImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "fitness4")
    view.layer.shadowOffset = CGSize(width: 5, height: 5)
    view.layer.shadowColor = UIColor.gray.cgColor
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  
  let progressView: UICircularProgressRingView = {
    let pv = UICircularProgressRingView()
    pv.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    pv.outerRingColor = .red
    return pv
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(view)
    addSubview(profileImageView)
    addSubview(progressView)
    
    
    backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    profileImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 30, width: 60, height: 60)
    profileImageView.layer.cornerRadius = 60 / 2
    profileImageView.clipsToBounds = true
    view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
    progressView.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: profileImageView.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
