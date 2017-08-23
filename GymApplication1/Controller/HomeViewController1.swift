//
//  HomeViewController1.swift
//  GymApplication1
//
//  Created by David on 16/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class HomeViewController1: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  let cellId = "CellId"
  
  var user: User? {
    didSet {
      print("POO")
      guard let userName = user?.username else { return }
      guard let points = user?.userPointsEarned else { return }
      greetingText.text = "Welcome \(userName), how are you feeling today?"
      setupProfileImage()
      if user?.userPointsEarned == 0 {
        pointsLabel.textColor = .red
        pointsLabel.text = "No points yet!"
      } else {
        pointsLabel.text = "Points: \(points)"
      }
      
      
    }
  }
  
  var classesAttending: ClassesAttending? {
    didSet {
      print("PAP \(classesAttending?.className)")
    }
  }
  
  let seperatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.alpha = 0.6
    view.layer.cornerRadius = 5
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.2
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowRadius = 1
    return view
  }()
  
  let pointsLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 22.0)
    return lbl
  }()
  
  let progressBar: UIProgressView = {
    let pb = UIProgressView()
    return pb
  }()
  
  let classView: UIView = {
    let v = UIView()
    v.backgroundColor = .white
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOpacity = 0.5
    v.layer.shadowOffset = CGSize(width: -1, height: 1)
    v.layer.shadowRadius = 1
    v.layer.cornerRadius = 3
    return v
  }()
  
  let profileImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.layer.borderWidth = 1
    iv.layer.borderColor = UIColor.black.cgColor
    iv.layer.cornerRadius = 5
    iv.layer.shadowColor = UIColor.black.cgColor
    iv.layer.shadowOpacity = 0.2
    iv.layer.shadowOffset = CGSize(width: 1, height: 1)
    iv.layer.shadowRadius = 1
    return iv
  }()
  
  let greetingText: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 30.0)
    return lbl
  }()
  
  lazy var welcomeView: UIView = {
    let v = UIView()
    return v
  }()
  
  let className: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white
    lbl.text = "Aqua"
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 34)
    return lbl
  }()
  
  let classDateAndTime: UILabel = {
    let lbl = UILabel()
    lbl.text = "Monday 24th August"
    lbl.textColor = .white
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
    return lbl
  }()
  
  let homeImageViewClass: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "aqua")
    return iv
  }()
  
  
  lazy var settingLaucnher: SettingsLaucnher = {
    let launcher = SettingsLaucnher()
    launcher.homeController = self
    return launcher
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    fetchUser()
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupViews()
    setupNavigationBar()
    setupLogOutButton()
    setupCalendarButton()
    fetchUser()
    
    //self.collectionView.reloadData()
    
    
  }
  
  func setupNavigationBar() {
    
    let logo = UIImage(named: "nuffield_logo")?.withRenderingMode(.alwaysOriginal)
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.image = logo
    
    self.navigationItem.titleView = imageView
    
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black, NSAttributedStringKey.font.rawValue: UIFont(name: "Avenir", size: 20) ?? ""]
    navigationController?.navigationBar.isTranslucent = false
  }
  
  func setupViews() {
    
    view.addSubview(welcomeView)
    view.addSubview(progressBar)
    welcomeView.addSubview(greetingText)
    welcomeView.addSubview(profileImageView)
    view.addSubview(pointsLabel)
    view.addSubview(seperatorView)
    view.addSubview(classView)
    view.addSubview(homeImageViewClass)
    view.addSubview(className)
    view.addSubview(classDateAndTime)
    
   // collectionView.register(HomeFeedCell.self, forCellWithReuseIdentifier: cellId)
    
    welcomeView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    seperatorView.anchor(top: greetingText.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.width, height: 2)
    
    greetingText.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
    
    profileImageView.anchor(top: greetingText.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 100)
    profileImageView.layer.cornerRadius = 100 / 2
    profileImageView.clipsToBounds = true
    
    progressBar.anchor(top: pointsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    
    classView.anchor(top: progressBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 175)
    
    pointsLabel.anchor(top: seperatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 180, height: 80)
    
    className.anchor(top: classView.topAnchor, left: classView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    classDateAndTime.anchor(top: className.bottomAnchor, left: classView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    homeImageViewClass.anchor(top: classView.topAnchor, left: classView.leftAnchor, bottom: classView.bottomAnchor, right: classView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    
    
  }
  
  fileprivate func setupLogOutButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSettingsLauncher))
  }
  
  @objc fileprivate func setupCalendarButton() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showCalendar))
  }
  
  @objc func showCalendar() {
    print(123)
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
      print("DAVIDPOO \(dictionary)")
      
      self.user = User(uid: uid, dictionary: dictionary)
      
      guard let classesAttending = dictionary["classesAttending"] as? [String: Any] else { return }
      print("DAVIDWARD \(classesAttending)")
      
      classesAttending.forEach({ (arg) in
        let (key, value) = arg
        
        guard let classAttendingDict = value as? [String: Any] else { return }
        let classes = ClassesAttending(classUID: key, dictionary: classAttendingDict)
        //self.classesAttendingArray.append(classes)
        print("MARNIE \(classes)")
        
        
      })
      
    }) { (err) in
      if err == nil {
        print("There was an error", err)
      }
    }
  }
  
  
  
  fileprivate func setupProfileImage() {
    guard let ptofileImageUrl = user?.profileImageUrl else { return }
    
    guard let url = URL(string: ptofileImageUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for the error and then construct the image using the data
      if let err = err {
        print("Failed to fetch profile image:", err)
        return
      }
      
      guard let data = data else { return }
      
      let image = UIImage(data: data)
      
      DispatchQueue.main.async {
        self.profileImageView.image = image
      }
      
      }.resume()
    
  }

  var arrayOfThings = [1, 2, 3, 4, 5, 6, 7, 8]
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfThings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeFeedCell
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 150)
  }
  
}
