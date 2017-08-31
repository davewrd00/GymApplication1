//
//  UsersToMessageViewController.swift
//  GymApplication1
//
//  Created by David on 30/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class UsersToMessageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var friendsUser = [User]()
  
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
    button.addTarget(self, action: #selector(handleExitFromMessageVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    navigationController?.hidesBarsOnSwipe = true
    navigationController?.navigationBar.tintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    tabBarController?.tabBar.isHidden = true
    
    collectionView?.register(MessageView.self, forCellWithReuseIdentifier: "cellId")
    
    view.addSubview(exitButton)
 
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    fetchWhoFriendsWith()
    //observeMessages()
  }
  
  @objc fileprivate func handleExitFromMessageVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return friendsUser.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MessageView
    cell.user = self.friendsUser[indexPath.item]
      return cell
   
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 80)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let layout = UICollectionViewFlowLayout()
    let privateMessageVC = PrivateMessageViewController(collectionViewLayout: layout)
    let user = self.friendsUser[indexPath.item]
    privateMessageVC.user = user
    print("PAHAHA \(user)")
    self.navigationController?.pushViewController(privateMessageVC, animated: true)
    
  }
  
  //  fileprivate func observeMessages() {
  //    let ref = Database.database().reference().child("privateMessages")
  //    ref.observe(.childAdded, with: { (snapshot) in
  //      print(snapshot.value)
  //      if !snapshot.exists() {
  //        return
  //      } else {
  //        guard let dictionary = snapshot.value as? [String: Any] else { return }
  //        let message = PrivateMessage(dictionary: dictionary)
  //        print(message.text)
  //        self.collectionView?.reloadData()
  //      }
  //    }) { (err) in
  //      print(err)
  //    }
  //  }
  
  fileprivate func fetchWhoFriendsWith() {
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let ref = Database.database().reference().child("friends").child(uid)
    ref.observe(.value) { (snapshot) in
      print("help \(snapshot.value)")
      
      guard let friendsDict = snapshot.value as? [String: Any] else { return }
      friendsDict.forEach({ (arg) in
        let (key, value) = arg
        
        print("FRAN \(key, value)")
        
        Database.database().reference().child("users").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
          print("BAN \(key)")
          
          guard let userDict = snapshot.value as? [String: Any] else { return }
            let user = User(uid: key, dictionary: userDict)
          print(user.username)
          print(user)
          self.friendsUser.append(user)
          self.collectionView?.reloadData()
        }, withCancel: { (err) in
          print(err)
        })
      })
    }
  }
  
  
  
}
