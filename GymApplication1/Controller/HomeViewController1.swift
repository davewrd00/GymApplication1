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
      print("POO \(user?.username, user?.uid)")
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
  
  var classDates = [String]() {
    didSet {
      print("JHDFHDJHFJDHFJDFH")
    }
  }
  
  var classesAttending = [ClassesAttending]() {
    didSet {
      for classes in classesAttending {
        print("VANDAME \(classes.classDate)")
        self.className.text = classes.className
        print("POPOPOPOP \(classes.className)")
        if classes.className == "Aqua" {
          homeImageViewClass.image = UIImage(named: "aqua")
        } else if classes.className == "Body Pump" {
          homeImageViewClass.image = UIImage(named: "fitness4")
        } else if classes.className == "Body Combat" {
          homeImageViewClass.image = UIImage(named: "bodycombat")
        } else if classes.className == "Pilates" {
          homeImageViewClass.image = UIImage(named: "pilates")
        } else if classes.className == "Synergy" {
          homeImageViewClass.image = UIImage(named: "synergy")
        } else {
          homeImageViewClass.image = UIImage(named: "yoga")
        }
        
        print("fanny \(classes.classDate)")
        classDates.append(classes.classDate)
        
        let dateString = classes.classDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
        guard let dateFromString = dateFormatter.date(from: dateString) else { return }

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMM d, yyyy"
        let stringFromDate = dateFormatter2.string(from: dateFromString)

        self.classDateAndTime.text = stringFromDate
        }
      
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
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 28.0)
    lbl.textColor = .black
    return lbl
  }()
  
  let medalImageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .yellow
    iv.layer.borderWidth = 1
    iv.layer.borderColor = UIColor.black.cgColor
    iv.layer.cornerRadius = 5
    iv.layer.shadowColor = UIColor.black.cgColor
    iv.layer.shadowOpacity = 0.2
    iv.layer.shadowOffset = CGSize(width: 1, height: 1)
    iv.layer.shadowRadius = 1
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
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
  
  @objc func handleTap() {
    print(123)
  }
  
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
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 32)
    return lbl
  }()
  
  lazy var welcomeView: UIView = {
    let v = UIView()
    return v
  }()
  
  let classButton: UIButton = {
    let btn = UIButton()
    let image = UIImage(named: "edit")
    btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    btn.addTarget(self, action: #selector(handleEditClass), for: .touchUpInside)
    btn.backgroundColor = .red
    btn.layer.cornerRadius = 3
    btn.alpha = 0.6
    return btn
  }()
  
  
  lazy var settingLaucnher: SettingsLaucnher = {
    let launcher = SettingsLaucnher()
    launcher.homeController = self
    return launcher
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = false
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .white
    self.fetchUserWithClass()
    
  }
  
  let homeImageViewClass: UIImageView = {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  let className: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    lbl.textColor = .white
    return lbl
  }()
  
  let classDateAndTime: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    lbl.textColor = .white
    return lbl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white

    setupViews()
    setupNavigationBar()
    setupLogOutButton()
    fetchUserWithClass()
  }
  
  func setupNavigationBar() {
    
    //    let logo = UIImage(named: "nuffield_logo")?.withRenderingMode(.alwaysOriginal)
    //    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    //    imageView.contentMode = .scaleAspectFit
    //    imageView.clipsToBounds = true
    //    imageView.image = logo
    //
    //    self.navigationItem.titleView = imageView
    
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue).rawValue): UIColor.black, NSAttributedStringKey(rawValue: NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue).rawValue): UIFont(name: "Avenir", size: 20) ?? ""]
    navigationController?.navigationBar.isTranslucent = false
  }
  
  func setupViews() {
    
    view.addSubview(welcomeView)
    welcomeView.addSubview(greetingText)
    welcomeView.addSubview(profileImageView)
    view.addSubview(seperatorView)
    view.addSubview(pointsLabel)
    view.addSubview(medalImageView)
    view.addSubview(classView)
    view.addSubview(homeImageViewClass)
    view.addSubview(className)
    view.addSubview(classDateAndTime)
    view.addSubview(classButton)
    
    
    classButton.anchor(top: nil, left: nil, bottom: homeImageViewClass.bottomAnchor, right: homeImageViewClass.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 50, height: 50)

    welcomeView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    seperatorView.anchor(top: greetingText.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.width, height: 2)
    
    greetingText.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
    
    profileImageView.anchor(top: greetingText.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 100)
    profileImageView.layer.cornerRadius = 100 / 2
    profileImageView.clipsToBounds = true
    
    classView.anchor(top: pointsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 175)
    
    pointsLabel.anchor(top: seperatorView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 180, height: 80)
    
    medalImageView.anchor(top: seperatorView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 80, height: 80)
   
    
    className.anchor(top: classView.topAnchor, left: classView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    classDateAndTime.anchor(top: className.bottomAnchor, left: classView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    homeImageViewClass.anchor(top: classView.topAnchor, left: classView.leftAnchor, bottom: classView.bottomAnchor, right: classView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    
    
  }
  
  @objc fileprivate func handleEditClass() {
    print(123)
    
    
  }
  
  fileprivate func setupLogOutButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSettingsLauncher))
  }
  
//  @objc fileprivate func setupCalendarButton() {
//    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showCalendar))
//  }
  
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
    if setting.name.rawValue == "Profile" {
      //let userLayout = UICollectionViewFlowLayout()
      let userProfileVC = UserProfileViewController()
      userProfileVC.userId = Auth.auth().currentUser?.uid
      navigationController?.pushViewController(userProfileVC, animated: true)
    } else {
      let dummyViewController = UIViewController()
      dummyViewController.navigationItem.title = setting.name.rawValue
      dummyViewController.view.backgroundColor = .white
      navigationController?.navigationBar.tintColor = .yellow
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue).rawValue): UIColor.white]
      navigationController?.pushViewController(dummyViewController, animated: true)
    }
    
  }

  fileprivate func fetchUserWithClass() {
    guard let uid = Auth.auth().currentUser?.uid else { return }

    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

      guard let dictionary = snapshot.value as? [String: Any] else { return }

      self.user = User(uid: uid, dictionary: dictionary)

      guard let classesAttending = dictionary["classesAttending"] as? [String: Any] else { return }
      print("DAVIDWARD \(classesAttending)")

      classesAttending.forEach({ (arg) in
        let (key, value) = arg
        print("NANA \(key)")
        guard let classAttendingDict = value as? [String: Any] else { return }
        let classes = ClassesAttending(classUID: key, dictionary: classAttendingDict)

        self.classesAttending.append(classes)
        print("MARNIE \(classes)")
        //let classDate = classes.classDate
        //self.classDates.append(classDate)
        self.compareDates(classesAttenidng: classes)
      })
      
      

    }) { (err) in
        print("There was an error", err)
    }
  }

  fileprivate func compareDates(classesAttenidng: ClassesAttending) {
    print("Comparing the dates...should see this twice!")
    //print("LALAL \(classesAttending)")
    print("Boob \(classesAttenidng.classDate)")

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
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: classView.frame.width, height: classView.frame.height)
  }
  
  
}



