//
//  AdminViewController.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class AdminViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
  
  var classImagesNames: [UIImage] = [
    
  ]
  
  var classNames = ["Aqua", "Body Combat", "Body Pump", "Pilates", "Synergy", "Yoga"]
  
  let cellId = "cellId"
  
  var classes = [Classes]()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .white
    return cv
  }()
  
  let exitButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.rgb(red: 242, green: 95, blue: 92)
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "exit")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleExitFromClassVC), for: .touchUpInside)
    button.alpha = 0.8
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = .white
    
    view.addSubview(collectionView)
    view.addSubview(exitButton)
    
    exitButton.anchor(top: nil, left: collectionView.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 60, paddingRight: 0, width: 50, height: 50)
    
    collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    collectionView.register(ClassAdminCell.self, forCellWithReuseIdentifier: cellId)
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = false
  }
  
  @objc func handleExitFromClassVC() {
      let alertController = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .actionSheet)
      alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
        
        do {
          try Auth.auth().signOut()
          let welcomeVC = WelcomeViewController()
          let navController = UINavigationController(rootViewController: welcomeVC)
          _ = KeychainWrapper.standard.removeObject(forKey: "uid")
          print("ID removed from keychain")
          self.present(navController, animated: true, completion: nil)
          
        } catch let signOutErr {
          print("Failed to signout of application", signOutErr)
        }
      }))
      alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
      present(alertController, animated: true, completion: nil)
    }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return classNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClassAdminCell
    cell.classNameLabel.text = self.classNames[indexPath.item]
    //cell.classImageView.image = self.classImagesNames[indexPath.item]
    if indexPath.item == 0 {
      
      cell.classImageView.image = UIImage(named: "aqua")
    } else if indexPath.item == 1 {
      
      cell.classImageView.image = UIImage(named: "bodycombat")
    } else if indexPath.item == 2 {
      
      cell.classImageView.image = UIImage(named: "fitness4")
    } else if indexPath.item == 3 {
      
      cell.classImageView.image = UIImage(named: "pilates")
    } else if indexPath.item == 4 {
      
      cell.classImageView.image = UIImage(named: "synergy")
    } else {
      
      cell.classImageView.image = UIImage(named: "yoga")
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.item)
    
    let classToAdd = self.classNames[indexPath.item]
    print(classToAdd)
    let classToAddVC = AddClassViewController()
    classToAddVC.classToAdd = classToAdd 
    self.present(classToAddVC, animated: true, completion: nil)

  }
  
}
