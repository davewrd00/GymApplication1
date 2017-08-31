//
//  EditClassViewController.swift
//  GymApplication1
//
//  Created by David on 28/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class EditClassViewController: UIViewController {
  
  var classToEdit: ClassesAttending? {
    didSet {
      guard let className = classToEdit?.className else { return }
      guard let locationOfClass = classToEdit?.classLocation else { return }
      print("WAAAA \(className )")
      self.className.text = classToEdit?.className
      
      guard let classDate = classToEdit?.classDate else { return }
      
      let dateString = classDate
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
      guard let dateFromString = dateFormatter.date(from: dateString) else { return }
      
      let dateFormatter2 = DateFormatter()
      dateFormatter2.dateFormat = "MMM d, yyyy - HH:mm"
      let stringFromDate = dateFormatter2.string(from: dateFromString)
      
      self.classDateAndTimeLabel.text = stringFromDate
      self.locationLabel.text = locationOfClass
    }
  }
  
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
    button.addTarget(self, action: #selector(handleExitFromEditClassVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  let cancelClassButton: UIButton = {
    let button = UIButton()
    button.setTitle("CANCEL CLASS", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    button.backgroundColor = .red
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    button.addTarget(self, action: #selector(handleCancelClass), for: .touchUpInside)
    button.alpha = 0.6
    return button
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
  
  let userProfileName: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    lbl.text = "David Ward"
    lbl.textColor = .black
    lbl.textAlignment = .center
    return lbl
  }()
  
  var className: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Light", size: 26)
    lbl.text = "Aqua"
    lbl.textAlignment = .center
    return lbl
  }()
  
  let classDateAndTimeLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Light", size: 14)
    lbl.text = "24th August, 2017 - 18:30"
    lbl.textAlignment = .center
    return lbl
  }()
  
  let locationLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "helveticaNeue-Light", size: 14)
    lbl.text = "STUDIO 4"
    lbl.textAlignment = .center
    return lbl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBarController?.tabBar.isHidden = true
    navigationController?.navigationBar.isHidden = true
    
    view.addSubview(exitButton)
    view.addSubview(classView)
    view.addSubview(userProfileName)
    view.addSubview(className)
    view.addSubview(classDateAndTimeLabel)
    view.addSubview(locationLabel)
 
    
    view.addSubview(cancelClassButton)
 
    classDateAndTimeLabel.anchor(top: className.bottomAnchor, left: classView.leftAnchor, bottom: nil, right: classView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    locationLabel.anchor(top: classDateAndTimeLabel.bottomAnchor, left: classView.leftAnchor, bottom: nil, right: classView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    className.anchor(top: userProfileName.bottomAnchor, left: classView.leftAnchor, bottom: nil, right: classView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    userProfileName.anchor(top: classView.topAnchor, left: classView.leftAnchor, bottom: nil, right: classView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    classView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 250)
    classView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    classView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    cancelClassButton.anchor(top: nil, left: exitButton.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 50)
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    view.backgroundColor = UIColor.rgb(red: 80, green: 81, blue: 79)
 
  }
  
  @objc func handleExitFromEditClassVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func handleCancelClass() {
    print("Cancelling this class!")
    
    guard let className = classToEdit?.className else { return }
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let classDate = classToEdit?.classDate else { return }
    guard let classUID = classToEdit?.classUID else { return }
    
    Database.database().reference().child("classesUsersAttending").child(uid).child(classDate).removeValue { (err, ref) in
      if let err = err {
        print("Failed to remove this class from the usewrs Database")
      }
      print("Successfully removed class from user DB")
      
      DataService.sharedInstance.updateValues(name: className, uid: classUID, newValue: +1, completionBlock: {
        print("Added 1 space to the class since this user just cancelled")
      })
      
      // Need to also remove this class from user calendar
      
      let tabBarVC = TabBarController()
      self.present(tabBarVC, animated: true, completion: nil)
    }
  }
  
  
  
  
  
}
