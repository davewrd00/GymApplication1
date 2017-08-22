//
//  GoalsViewHeader.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class GoalsViewHeader: UICollectionViewCell {
  
  let label: UILabel = {
    let lbl = UILabel()
    lbl.text = "Choose a goal:"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 36.0)
    lbl.textColor = .white
    lbl.textAlignment = .center
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.rgb(red: 72, green: 172, blue: 240)
    
    addSubview(label)
    
    label.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
