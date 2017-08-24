//
//  AddGoalViewController.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class AddGoalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
  
  let topView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.rgb(red: 72, green: 172, blue: 240)
    return v
  }()
  
  let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.translatesAutoresizingMaskIntoConstraints = false
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
    return button
  }()
  
  let exitButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.rgb(red: 242, green: 95, blue: 92)
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "exit")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleBackFromClassVC), for: .touchUpInside)
    button.alpha = 0.8
    return button
  }()
  
  let enterButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.rgb(red: 59, green: 193, blue: 74)
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "add_btn")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleAddFromClassVC), for: .touchUpInside)
    button.alpha = 0.7
    return button
  }()
  
  let goalNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Goal name:"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    lbl.textColor = .black
    return lbl
  }()
  
  let goalTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Enter a goal name", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  let goalDescriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Goal Description:"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    lbl.textColor = .black
    return lbl
  }()
  
  let goalDescriptionTextField: UITextView = {
    let tf = UITextView()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  let goalPointsLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Number of points goal is worth:"
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    lbl.textColor = .black
    lbl.numberOfLines = 0
    return lbl
  }()
  
  let goalPointsTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Enter a number", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    tf.keyboardType = .numberPad
    return tf
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    view.addSubview(topView)
    view.addSubview(goalNameLabel)
    view.addSubview(enterButton)
    view.addSubview(exitButton)
    view.addSubview(goalTextField)
    view.addSubview(goalDescriptionLabel)
    view.addSubview(goalDescriptionTextField)
    view.addSubview(goalPointsLabel)
    view.addSubview(goalPointsTextField)
    view.addSubview(plusPhotoButton)
    
    topView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
    
    plusPhotoButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
    plusPhotoButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
    plusPhotoButton.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    
    enterButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 55, paddingRight: 10, width: 50, height: 50)
    
     exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 55, paddingRight: 0, width: 50, height: 50)
    
    goalNameLabel.anchor(top: topView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
    
    goalTextField.anchor(top: goalNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 300, height: 40)
    goalTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    goalDescriptionLabel.anchor(top: goalTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
    
    goalDescriptionTextField.anchor(top: goalDescriptionLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 300, height: 100)
    goalDescriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    goalPointsLabel.anchor(top: goalDescriptionTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 300, height: 80)
    
    goalPointsTextField.anchor(top: goalPointsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 300, height: 40)
    goalPointsTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
  }
  
  @objc func handleAddFromClassVC() {
    print(123)
    let points: Int? = Int(self.goalPointsTextField.text!)
    if goalTextField.text == "" || goalDescriptionTextField.text == "" || goalPointsTextField.text == "" {
      let alertController = UIAlertController(title: "Howay man!", message: "You need to fill in all the fields!", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(alertAction)
      present(alertController, animated: true, completion: nil)
    } else {
      
      guard let image = self.plusPhotoButton.imageView?.image else { return }
      
      guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
      
      let fileName = NSUUID().uuidString
      
      Storage.storage().reference().child("goal_images").child(fileName).putData(uploadData, metadata: nil) { (metadata, err) in
        if let err = err {
          print("Failed to upload profile image", err)
          return
        }
        
        guard let goalImageUrl = metadata?.downloadURL()?.absoluteString else { return }
        
        print("Successfully uploaded the goal image URL")
      
      let goalInfo: Dictionary<String, Any>
      let timeStamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
      
      goalInfo = ["goalName": self.goalTextField.text ?? "",
                  "goalDescription": self.goalDescriptionTextField.text ?? "",
                  "goalPoints": points,
                  "goalImageUrl": goalImageUrl,
                  "goalUID": timeStamp]
      
        
      Database.database().reference().child("goals").child("\(timeStamp)").setValue(goalInfo)
        
    }
    
  }
    
  }
  
  @objc func handleBackFromClassVC() {
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
  
  @objc func handlePlusPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
      plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.black.cgColor
    plusPhotoButton.layer.borderWidth = 3
    
    dismiss(animated: true, completion: nil)
  }
  
  
  
}
