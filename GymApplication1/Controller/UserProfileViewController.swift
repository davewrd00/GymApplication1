//
//  UserProfileViewController.swift
//  GymApplication1
//
//  Created by David on 24/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  
  let headerId = "headerId"
  
  let header2 = "headerId2"
  
  let cellId = "cellId"
  
  var userId: String?
  
  
  
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
  
  let privateMessageButton: UIButton = {
    let btn = UIButton()
    btn.layer.cornerRadius = 5
    btn.layer.shadowColor = UIColor.black.cgColor
    btn.layer.shadowOpacity = 0.2
    btn.layer.shadowOffset = CGSize(width: 1, height: 1)
    btn.layer.shadowRadius = 1
    btn.backgroundColor = .blue
    btn.alpha = 0.6
    let image = UIImage(named: "message-1")
    btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    btn.addTarget(self, action: #selector(handlePrivateMessageBtnTapped), for: .touchUpInside)
    btn.isEnabled = false
    return btn
  }()
  
  let topView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    return v
  }()
  
  let pointsView: UIView = {
    let v = UIView()
    v.backgroundColor = .white
    v.layer.cornerRadius = 3
    return v
  }()
  
  let achievementsView: UIView = {
    let v = UIView()
    v.backgroundColor = .white
    v.layer.cornerRadius = 3
    return v
  }()
  
  let restOfView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    return v
  }()
  
  let becomesFriendsBtn: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    btn.setTitle("Mates?", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    btn.layer.cornerRadius = 3
    btn.layer.borderColor = UIColor.black.cgColor
    btn.layer.borderWidth = 1
    btn.addTarget(self, action: #selector(handleBecomeFreindsBtnTapped), for: .touchUpInside)
    btn.alpha = 0.6
    return btn
  }()
  
  let niceView: UIView = {
    let v = UIView()
    v.backgroundColor = .white
    v.layer.cornerRadius = 5
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOpacity = 0.2
    v.layer.shadowOffset = CGSize(width: 1, height: 1)
    v.layer.shadowRadius = 1
    return v
  }()
  
  let restOfNiceView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    return v
  }()
  
  let userProfileView: CustomImageView = {
    let iv = CustomImageView()
    iv.backgroundColor = .blue
    iv.layer.borderColor = UIColor.black.cgColor
    iv.layer.borderWidth = 1
    iv.layer.shadowColor = UIColor.black.cgColor
    iv.layer.shadowOpacity = 0.2
    iv.layer.shadowOffset = CGSize(width: 1, height: 1)
    iv.layer.shadowRadius = 1
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let userNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26.0)
    lbl.textColor = .black
    lbl.text = "Catherine Evans"
    lbl.textAlignment = .center
    return lbl
  }()
  
  let achievementLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Achievements"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    lbl.textColor = .black
    lbl.textAlignment = .center
    return lbl
  }()
  
  let pointsLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.text = "Points"
    lbl.textAlignment = .center
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    lbl.textAlignment = .center
    return lbl
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .yellow
    return cv
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBarController?.tabBar.isHidden = true
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header2)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    setupViews()
    fetchUser()
    
  }
  
  fileprivate func setupViews() {
    view.addSubview(restOfView)
    view.addSubview(topView)
    view.addSubview(niceView)
    view.addSubview(userProfileView)
    view.addSubview(userNameLabel)
    view.addSubview(becomesFriendsBtn)
    view.addSubview(restOfNiceView)
    view.addSubview(achievementsView)
    view.addSubview(pointsView)
    view.addSubview(achievementLabel)
    view.addSubview(pointsLabel)
    view.addSubview(collectionView)
    
    
    view.addSubview(exitButton)
    view.addSubview(privateMessageButton)
    
    collectionView.anchor(top: achievementLabel.bottomAnchor, left: achievementsView.leftAnchor, bottom: achievementsView.bottomAnchor, right: achievementsView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    achievementLabel.anchor(top: achievementsView.topAnchor, left: achievementsView.leftAnchor, bottom: nil, right: achievementsView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 0)
    
    pointsLabel.anchor(top: pointsView.topAnchor, left: pointsView.leftAnchor, bottom: nil, right: pointsView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    pointsView.anchor(top: restOfNiceView.topAnchor, left: achievementsView.rightAnchor, bottom: nil, right: restOfNiceView.rightAnchor, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2, width: 0, height: 150)
    
    achievementsView.anchor(top: restOfNiceView.topAnchor, left: restOfNiceView.leftAnchor, bottom: restOfNiceView.bottomAnchor, right: nil, paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 0, width: 200, height: 200)
    
    restOfNiceView.anchor(top: restOfView.topAnchor, left: restOfView.leftAnchor, bottom: restOfView.bottomAnchor, right: restOfView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    
    restOfView.anchor(top: becomesFriendsBtn.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 300)
    
    becomesFriendsBtn.anchor(top: topView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 30)
    becomesFriendsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    privateMessageButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 50, height: 50)
    
    userProfileView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 90)
    userProfileView.centerXAnchor.constraint(equalTo: niceView.centerXAnchor).isActive = true
    userProfileView.centerYAnchor.constraint(equalTo: niceView.centerYAnchor).isActive = true
    userProfileView.layer.cornerRadius = 90 / 2
    
    niceView.anchor(top: topView.topAnchor, left: topView.leftAnchor, bottom: topView.bottomAnchor, right: topView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    
    userNameLabel.anchor(top: userProfileView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 0)
    userNameLabel.centerXAnchor.constraint(equalTo: niceView.centerXAnchor).isActive = true
    
    topView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 200)
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
  }
  
  
  @objc func handleExitFromUserProfileVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func handlePrivateMessageBtnTapped() {
    print(123)
  }
  
  @objc func handleBecomeFreindsBtnTapped() {
    print(456)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 50)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header2, for: indexPath)
    header.backgroundColor = .red
    return header
  }
  
  var user: User? {
    didSet {
      print("USERNAME \(user?.uid)")
    }
  }
  
  func fetchUser() {
  
    let uid = userId ?? Auth.auth().currentUser?.uid ?? ""
    
    Database.fetchUserWithUID(uid: uid) { (user) in
      self.user = user
      
      self.userNameLabel.text = self.user?.username
      
      guard let userImageUrl = self.user?.profileImageUrl else { return }
      
      self.userProfileView.loadImage(urlString: userImageUrl)
      
      self.collectionView.reloadData()
      
      
    }
    
      
  }
    
    
    
    
  
}
