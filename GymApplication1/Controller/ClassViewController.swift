//
//  ClassViewController.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class ClassViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
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
    button.addTarget(self, action: #selector(handleExitFromClassVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  let cellId = "cellId"
  
  lazy var searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.placeholder = "Search class"
    sb.barTintColor = .gray
    sb.backgroundColor = .clear
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
    sb.delegate = self
    sb.searchBarStyle = .minimal
    return sb
  }()
  
  var classes = [Classes]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Classes"
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white, NSAttributedStringKey.font.rawValue: UIFont(name: "Avenir", size: 20)]
    navigationController?.navigationBar.isTranslucent = false
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    collectionView?.register(ClassCellView.self, forCellWithReuseIdentifier: cellId)
    collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
    self.tabBarController?.tabBar.isHidden = true
  
    view.addSubview(exitButton)
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    setupMenuBar()
    
    collectionView?.contentInset = UIEdgeInsetsMake(30, 0, 0, 0 )
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(30, 0, 0, 0)
    
    tabBarItem.title = "Classes"
    
    fetchClasses()

  }
  
  let menuBar: MenuBarView = {
    let mb = MenuBarView()
    mb.backgroundColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    return mb
  }()
  
  fileprivate func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat(format: "V:|[v0(40)]|", views: menuBar)
    view.addSubview(searchBar)
    searchBar.anchor(top: menuBar.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -11, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
  }
  
  @objc func handleExitFromClassVC() {
    let tabBarController = TabBarController()
    self.present(tabBarController, animated: true, completion: nil)
  }
  
  fileprivate func fetchClasses() {
    print("Fetching classes...")
    
    let ref = Database.database().reference().child("classes")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      print(dictionary)
      
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        print(key)
        
      
      guard let classDictionary = value as? [String: Any] else { return }
      let classes = Classes(className: key, dictionary: classDictionary)
        self.classes.append(classes)
        print("DAVID: \(classes)")
      })
      self.collectionView?.reloadData()
    }) { (err) in
      print("Failed to fecth users during search", err)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return classes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClassCellView
    
    cell.classes = classes[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath)
    header.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 10)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  

  
}
