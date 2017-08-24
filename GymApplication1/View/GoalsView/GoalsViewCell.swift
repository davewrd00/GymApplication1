//
//  GoalsViewCell.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class GoalsViewCell: UICollectionViewCell {
  
  var goals: Goals? {
    didSet {
      print("Goal being set!!")
      goalName.text = goals?.goalName
      goalDescription.text = goals?.goalDescription
      guard let points = goals?.goalPoints else { return }
      goalPointsLabel.text = ("\(points) points")
      setupGoalImage()
    }
  }
  
  let pointsView: UIView = {
    let v = UIView()
    v.backgroundColor = .clear
    return v
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
  
  let goalImageView: CustomImageView = {
    let iv = CustomImageView()
 
    return iv
  }()
  
  let goalPointsLabel: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    return lbl
  }()
  
  let goalName: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26.0)
    return lbl
  }()
  
  let goalDescription: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    addSubview(cellView)
    addSubview(goalImageView)
    addSubview(goalName)
    addSubview(goalDescription)
    addSubview(goalPointsLabel)
    addSubview(pointsView)
    
    pointsView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 8, width: 70, height: 70)
    
    cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 4, paddingRight: 8, width: 0, height: 0)
    
    goalPointsLabel.anchor(top: pointsView.topAnchor, left: pointsView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
    goalPointsLabel.centerYAnchor.constraint(equalTo: pointsView.centerYAnchor).isActive = true
    
    
    goalImageView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 0, width: 80, height: cellView.frame.height)
    
    goalName.anchor(top: goalImageView.topAnchor, left: goalImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 300, height: 40)
    
    goalDescription.anchor(top: goalName.bottomAnchor, left: goalName.leftAnchor, bottom: nil, right: pointsView.leftAnchor, paddingTop: 4, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 180, height: 40)
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setupGoalImage() {
    guard let goalImageUrl = goals?.goalImageUrl else { return }
    
    guard let url = URL(string: goalImageUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for the error and then construct the image using the data
      if let err = err {
        print("Failed to fetch profile image:", err)
        return
      }
      
      guard let data = data else { return }
      
      let image = UIImage(data: data)
      
      DispatchQueue.main.async {
        self.goalImageView.image = image
      }
      
      }.resume()
    
  }
  
  
  
}
