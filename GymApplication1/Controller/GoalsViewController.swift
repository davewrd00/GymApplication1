//
//  GoalsViewController.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import UICircularProgressRing

class GoalsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(GoalsViewCell.self, forCellWithReuseIdentifier: "cellId")
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! GoalsViewCell
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  
}
