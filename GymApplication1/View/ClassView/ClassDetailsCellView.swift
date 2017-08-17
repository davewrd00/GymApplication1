//
//  ClassDetailsCellView.swift
//  GymApplication1
//
//  Created by David on 14/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassDetailsViewCell: UICollectionViewCell {
  
  let classTimeLbl = UILabel()
  
  let classDurationLbl = UILabel()
  
  let classNameLbl = UILabel()
  
  let classLocationLbl = UILabel()
  
  let classInstructorNameLbl = UILabel()
  
  let classAvailabilityLbl = UILabel()
  
  var classes: Classes? {
    didSet {
      
      // Changes the date label into a more human-friendly string
      guard let dateString = classes?.classDate else { return }
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
      guard let dateFromString = dateFormatter.date(from: dateString) else { return }
      
      let dateFormatter2 = DateFormatter()
      dateFormatter2.dateFormat = "MMM d, yyyy"
      
      let stringFromDate = dateFormatter2.string(from: dateFromString)
      
      let timeFormatter2 = DateFormatter()
      timeFormatter2.dateFormat = "HH:mm"
      
      let stringFromTime = timeFormatter2.string(from: dateFromString)
      
      
      dateLabel.text = stringFromDate
      classTimeLbl.text = stringFromTime
      classDurationLbl.text = classes?.classDuration
      classNameLbl.text = classes?.className
      classLocationLbl.text = classes?.classLocation
    }
  }
  
  lazy var cellView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: -1, height: 1)
    view.layer.shadowRadius = 1
    view.layer.cornerRadius = 3
    view.addSubview(self.classTimeLbl)
    view.addSubview(self.classDurationLbl)
    view.addSubview(self.classNameLbl)
    view.addSubview(self.classLocationLbl)
    
    self.classLocationLbl.anchor(top: self.classNameLbl.bottomAnchor, left: self.classTimeLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 22, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    self.classLocationLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    self.classNameLbl.anchor(top: view.topAnchor, left: self.classTimeLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    self.classNameLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    self.classDurationLbl.anchor(top: self.classTimeLbl.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 22, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    self.classTimeLbl.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    // Customisation point for labels inside of each view
    self.classTimeLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    self.classDurationLbl.font = UIFont(name: "HelveticaNeue-Light", size: 10)
    self.classNameLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    self.classLocationLbl.font = UIFont(name: "HelveticaNeue-Light", size: 10)
    
    
    
    return view
  }()
  
  lazy var dateLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "Avenir-Light", size: 12)
    lbl.textAlignment = .center
    lbl.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 6)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(cellView)
    addSubview(dateLabel)
    
    
    dateLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: -3, paddingRight: 0, width: 0, height: 0 )
    
    
    cellView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
  }
  
  
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
