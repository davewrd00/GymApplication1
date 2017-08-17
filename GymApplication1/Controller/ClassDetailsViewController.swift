//
//  ClassDetailsViewController.swift
//  GymApplication1
//
//  Created by David on 14/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class ClassDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  var classes: Classes? {
    didSet {
      print("PAUL \(classes?.className)")
    }
  }
  
  var classDetails = [Classes]()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  let exitButton: UIButton = {
    let button = UIButton()
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
  
  lazy var imageOfClass: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    if self.classes?.className == "Aqua" {
      iv.image = UIImage(named: "aqua")
    } else if self.classes?.className == "Body Pump" {
      iv.image = UIImage(named: "fitness4")
    } else if self.classes?.className == "Body Combat" {
      iv.image = UIImage(named: "bodycombat")
    } else if self.classes?.className == "Pilates" {
      iv.image = UIImage(named: "pilates")
    } else if self.classes?.className == "Synergy" {
      iv.image = UIImage(named: "synergy")
    } else {
      iv.image = UIImage(named: "yoga")
    }
    
    let lbl = UILabel()
    lbl.textAlignment = .center
    lbl.text = self.classes?.className
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 36.0)
    lbl.textColor = .white
    lbl.translatesAutoresizingMaskIntoConstraints = false
    iv.addSubview(lbl)
    lbl.anchor(top: nil, left: iv.leftAnchor, bottom: iv.bottomAnchor, right: iv.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 80, height: 0)
    lbl.centerXAnchor.constraint(equalTo: iv.centerXAnchor).isActive = true
    lbl.centerYAnchor.constraint(equalTo: iv.centerYAnchor).isActive = true
    
    return iv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.isHidden = true
    
    view.addSubview(imageOfClass)
    view.addSubview(collectionView)
    view.addSubview(exitButton)
    view.addSubview(backButton)
    
    fetchDetailClasses()
    
    collectionView.register(ClassDetailsViewCell.self, forCellWithReuseIdentifier: "cellId")
    
    imageOfClass.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
    view.backgroundColor = .white
    
    collectionView.anchor(top: imageOfClass.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    backButton.anchor(top: nil, left: exitButton.rightAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    
  }
  
  func fetchDetailClasses() {
    print(123)
    
    guard let className = classes?.className else { return }
    let ref = Database.database().reference().child("classes").child(className)
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      print("WAW:M \(snapshot)")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      print("CATHEY \(dictionary)")
      
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        print(key)
        
        guard let individualClassDictionary = value as? [String: Any] else { return }
        print("CATHEY \(individualClassDictionary)")
        let eachClass = Classes(className: className, dictionary: individualClassDictionary)
        self.classDetails.append(eachClass)
        print("PAUL: \(eachClass)")
      })
      
      self.collectionView.reloadData()
      
      
    }) { (err) in
      print("Failed to fetch individual classes")
    }
  }
  
  @objc func handleExitFromClassVC() {
    let tabBarController = TabBarController()
    self.present(tabBarController, animated: true, completion: nil)
  }
  
  @objc func handleBackButton() {
    self.navigationController?.popViewController(animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return classDetails.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ClassDetailsViewCell
    
    cell.classes = classDetails[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  
  //Mammoth function - Need to refactor and utilise MVC better!
  func performClassTouchedView(classTouched: Classes) {
    print("This is a test to see if this works: Class name is: \(classTouched.className), date of this class will be \(classTouched.classDate)")
    let acceptClassVC = AcceptClassViewController()
    acceptClassVC.classes = classTouched
    self.present(acceptClassVC, animated: true, completion: nil)
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let classTouched = classDetails[indexPath.item]
    
    performClassTouchedView(classTouched: classTouched)
  }
  
}
