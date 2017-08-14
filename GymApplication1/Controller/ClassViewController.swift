//
//  ClassViewController.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class ClassViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Classes"
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white, NSAttributedStringKey.font.rawValue: UIFont(name: "Avenir", size: 20)]
    navigationController?.navigationBar.isTranslucent = false
    collectionView?.backgroundColor = .white
    
    collectionView?.register(ClassCellView.self, forCellWithReuseIdentifier: cellId)
    self.tabBarController?.tabBar.isHidden = true
    
    view.addSubview(exitButton)
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    setupMenuBar()
    
    collectionView?.contentInset = UIEdgeInsetsMake(30, 0, 0, 0 )
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(30, 0, 0, 0)
    
    tabBarItem.title = "Classes"

  }
  
  let menuBar: MenuBarView = {
    let mb = MenuBarView()
    mb.backgroundColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    return mb
  }()
  
  fileprivate func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat(format: "V:|[v0(30)]|", views: menuBar)
  }
  
  @objc func handleExitFromClassVC() {
    let tabBarController = TabBarController()
    self.present(tabBarController, animated: true, completion: nil)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClassCellView
    //cell.backgroundColor = .red
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  

  
}
