//
//  UserSearchController.swift
//  GymApplication1
//
//  Created by David on 22/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
  var users = [User]()
  
  var filteredUsers = [User]()
  
  let exitButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .red
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "back_btn")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleExitFromSearchVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  lazy var searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.placeholder = "Enter username"
    sb.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
    sb.delegate = self
    sb.searchBarStyle = .minimal
    return sb
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.navigationBar.addSubview(searchBar)
    
    let navBar = navigationController?.navigationBar
    
    view.addSubview(exitButton)
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 60, paddingRight: 0, width: 50, height: 50)
    searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(SearchCellView.self, forCellWithReuseIdentifier: "cellId")
    
    fetchUsers()
  }
  
  fileprivate func fetchUsers() {
    guard let myUid = Auth.auth().currentUser?.uid else { return }
    let ref = Database.database().reference().child("users")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        
        if key == myUid {
          print("Found myself here like")
          return
        }
        
        guard let userDictionary = value as? [String: Any] else { return }
        let user = User(dictionary: userDictionary)
        self.users.append(user)
        print(user.username)
      })
      
      // Sort the list alphabetically
      self.users.sort(by: { (u1, u2) -> Bool in
        return u1.username.compare(u2.username) == .orderedAscending
      })
      
      self.filteredUsers = self.users
      self.collectionView?.reloadData()
      
    }) { (err) in
      print("Failed to fetch all the users:", err)
      return
    }
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredUsers = users
    } else {
      filteredUsers = self.users.filter({ (user) -> Bool in
        return user.username.lowercased().contains(searchText.lowercased())
      })
    }
  }
  
  @objc func handleExitFromSearchVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredUsers.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchCellView
    //cell.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    cell.user = filteredUsers[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
