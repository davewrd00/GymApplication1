//
//  UserProfileViewController.swift
//  GymApplication1
//
//  Created by David on 24/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class UserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let headerId = "headerId"
  
  let cellId = "cellId"
  
  let exitButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.text = "X"
    button.backgroundColor = .red
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "exit")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleExitFromUserProfileVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBarController?.tabBar.isHidden = true
    collectionView?.backgroundColor = .white
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    collectionView?.register(UserProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    
    view.addSubview(exitButton)
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    //header.backgroundColor = .blue
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 150)
  }
  
  @objc func handleExitFromUserProfileVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .purple
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
    
    
    
    
  
}
