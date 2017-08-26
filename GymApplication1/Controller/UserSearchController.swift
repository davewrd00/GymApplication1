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
  
  let backButton: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .red
    btn.layer.cornerRadius = 5
    btn.layer.shadowColor = UIColor.black.cgColor
    btn.layer.shadowOpacity = 0.2
    btn.layer.shadowOffset = CGSize(width: 1, height: 1)
    btn.layer.shadowRadius = 1
    let image = UIImage(named: "back_btn")
    btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    btn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
    btn.alpha = 0.6
    return btn
  }()
  
  let menuBar: MenuBarView = {
    let mb = MenuBarView()
    mb.backgroundColor = .yellow
    return mb
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
    tabBarController?.tabBar.isHidden = true
    view.addSubview(backButton)
    backButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)

    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(SearchCellView.self, forCellWithReuseIdentifier: "cellId")
    
    collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    
    fetchUsers()
    setupMenuBar()
  }
  
  fileprivate func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat(format: "V:|[v0(40)]|", views: menuBar)
    view.addSubview(searchBar)
    searchBar.anchor(top: menuBar.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -8, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
  }
  
  @objc func handleBackButton() {
    self.navigationController?.popViewController(animated: true)
  }

  fileprivate func fetchUsers() {
    let ref = Database.database().reference().child("users")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        
        if key == Auth.auth().currentUser?.uid {
          print("Found myself here like")
          return
        }
        
        guard let userDictionary = value as? [String: Any] else { return }
        let user = User(uid: key, dictionary: userDictionary)
        self.users.append(user)
        print("BRADY \(user.username)")
        print("BRADY \(user.uid)")
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
    self.collectionView?.reloadData()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredUsers.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchCellView
    cell.user = filteredUsers[indexPath.item]
    print("POOO \(cell.user?.uid)")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    searchBar.resignFirstResponder()
    
    let user = filteredUsers[indexPath.item]
    print("PAP \(user)")
    print("POOOOOOOOO \(user.username)")
    print("POOOOOOOOO \(user.uid)")
    
    let userProfileControlller = UserProfileViewController()
    userProfileControlller.userId = user.uid
    navigationController?.pushViewController(userProfileControlller, animated: true)
    
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
}
