//
//  SocialCommunityViewController.swift
//  GymApplication1
//
//  Created by David on 22/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class SocialCommunityViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    navigationController?.navigationBar.isTranslucent = false
    
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    
  }
  
  fileprivate func  setupNavBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "write").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleWriteToFeed))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearchForFriends))
  }
  
  @objc func handleWriteToFeed() {
    print(123)
  }
  
  @objc func handleSearchForFriends() {
    let searchLayout = UICollectionViewFlowLayout()
    let userSearchController = UserSearchController(collectionViewLayout: searchLayout)
    navigationController?.pushViewController(userSearchController, animated: true)
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    cell.backgroundColor = .white

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  
}
