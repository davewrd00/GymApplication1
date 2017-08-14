//
//  MenuBarView.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class MenuBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let dates: [String] = ["Today", "Tomorrow", "Tuesday 15th August", "Wednesday 16th August", "Thursday 17th August", "Friday 18th August", "Saturday 19th August"]
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  let cellId = "cellId"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(collectionView)
    addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
    addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    
    collectionView.register(MenuBarViewCell.self, forCellWithReuseIdentifier: cellId)
    
    backgroundColor = UIColor.rgb(red: 80, green: 81, blue: 79)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dates.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarViewCell
    cell.dateAndTimeLabel.text = dates[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 120, height: 20)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
