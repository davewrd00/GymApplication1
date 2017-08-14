//
//  HomeViewController.swift
//  GymApplication1
//
//  Created by David on 09/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var user: User?
  let cellId = "cellId"
  
  lazy var settingLaucnher: SettingsLaucnher = {
    let launcher = SettingsLaucnher()
    launcher.homeController = self
    return launcher
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Home"
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black, NSAttributedStringKey.font.rawValue: UIFont(name: "Avenir", size: 20)]
    navigationController?.navigationBar.isTranslucent = false
    
    collectionView?.backgroundColor = .white
    
    setupLogOutButton()
    fetchUser()
    
    collectionView?.register(HomeHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
    collectionView?.register(HomeClassCell.self, forCellWithReuseIdentifier: cellId)
    collectionView?.register(HomeFooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerId")
    
    collectionView?.register(HomeGoalsCell.self, forCellWithReuseIdentifier: "cellId1")
    collectionView?.register(HomeFeedCell.self, forCellWithReuseIdentifier: "cellId2")
    
    
  }

  
  fileprivate func setupLogOutButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSettingsLauncher))
    
  }
  
  @objc func handleSettingsLauncher() {
    settingLaucnher.showSettings()
  }
  
  @objc func handleLogOut() {
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
  
  func showSettingsController(setting: Setting) {
    let dummyViewController = UIViewController()
    dummyViewController.navigationItem.title = setting.name.rawValue
    dummyViewController.view.backgroundColor = .white
    navigationController?.navigationBar.tintColor = .yellow
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    navigationController?.pushViewController(dummyViewController, animated: true)
  }
  
  fileprivate func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      self.user = User(dictionary: dictionary)
      
      //self.navigationItem.title = self.user?.username
      print(self.user?.username ?? "")
      
      self.collectionView?.reloadData()
      
    }) { (err) in
      if err != nil {
        print("There was an error", err)
      }
    }
  }
  
  // MARK :- Collection view implementation
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! HomeHeaderCell
    
    header.user = self.user
    
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 140)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeClassCell
      
      return cell
    } else if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId1", for: indexPath) as! HomeGoalsCell
      cell.backgroundColor = .lightGray
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath) as! HomeFeedCell
      return cell
    }
    
  }
  
  var array = [1, 2, 3, 4, 5, 6, 7, 8]
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.width
    if indexPath.item == 0 {
      return CGSize(width: width, height: 60)
    } else if indexPath.item == 1 {
      return CGSize(width: width, height: 120)
    } else {
      return CGSize(width: width, height: 140)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  
  
  
}

struct User {
  let username: String
  let profileImageUrl: String
  
  init(dictionary: [String: Any]) {
    self.username = dictionary["username"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
  }
  
  
  
}
