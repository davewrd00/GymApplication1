//
//  AchievementsViewController.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class AchievementsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white, NSAttributedStringKey.font.rawValue: UIFont(name: "Avenir", size: 20) ?? ""]
    navigationController?.navigationBar.isTranslucent = false
    collectionView?.backgroundColor = .white
    collectionView?.register(AchievementsCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView?.delegate = self
    collectionView?.dataSource = self
    
    tabBarItem.title = "Achievements"
    

  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 15
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! AchievementsCell
    print(123)

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 2) / 3
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.item)
    
  }
  
  
  
}
