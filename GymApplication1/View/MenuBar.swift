//
//  MenuBar.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .red
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  let cellId = "cellId"
  
  var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    
    addSubview(collectionView)
    addConstraintsWithFormat(format: "H:|[v0]", views: collectionView)
    addConstraintsWithFormat(format: "V:|[v0]", views: collectionView)
    
    setupHorizontalBar()
    
  }
  
  func setupHorizontalBar() {
    
    let horizontalBar = UIView()
    horizontalBar.backgroundColor = .purple
    horizontalBar.translatesAutoresizingMaskIntoConstraints = false
    addSubview(horizontalBar)
    
    horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
    horizontalBarLeftAnchorConstraint?.isActive = true
    horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
    horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Hello")
  }
  
  @available(iOS 6.0, *)
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  @available(iOS 6.0, *)
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
    
    if indexPath.item == 0 {
      cell.dateAndTimeLabel.text = "Today"
      return cell
    } else if indexPath.item == 1 {
      cell.dateAndTimeLabel.text = "Tomorrow"
      return cell
    } else if indexPath.item == 2 {
      cell.dateAndTimeLabel.text = "Tuesday 15th August"
      return cell
    } else if indexPath.item == 3 {
      cell.dateAndTimeLabel.text = "Wednesday 16th August"
      return cell
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 4, height: frame.height)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  
  
}
