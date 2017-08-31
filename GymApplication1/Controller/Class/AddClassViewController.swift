//
//  AddClassViewController.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class AddClassViewController: UINavigationController {
  
  var classToAdd: String?
  
  var nameLabel = UILabel()
  
  lazy var imageView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor.rgb(red: 72, green: 172, blue: 240)
    self.nameLabel.text = self.classToAdd 
    self.nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 36.0)
    self.nameLabel.textColor = .white
    v.addSubview(self.nameLabel)
    self.nameLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    self.nameLabel.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
    self.nameLabel.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
    return v
  }()
  
  let backButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.rgb(red: 242, green: 95, blue: 92)
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "back_btn")
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
  
  let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.datePickerMode = UIDatePickerMode.dateAndTime
    return dp
  }()
  
  let classAvailabilityTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Spaces available", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  let classDescriptionTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Description of class", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  let classDurationTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Duration of class", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  let classLocationTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Location of class", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  let classLevelTextField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = .clear
    tf.textColor = .black
    tf.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    tf.attributedPlaceholder = NSAttributedString(string: "Level of class", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16) ?? "", NSAttributedStringKey.foregroundColor: UIColor.black])
    tf.layer.borderColor = UIColor.rgb(red: 72, green: 172, blue: 240).cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    return tf
  }()
  
  @objc func handleAddFromClassVC() {
    print(123)
    
    if datePicker.date == nil || classLocationTextField.text == "" || classDurationTextField.text == "" || classAvailabilityTextField.text == "" {
      let alertController = UIAlertController(title: "Oops", message: "Please make sure that you complete all of the above fields", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(alertAction)
      present(alertController, animated: true, completion: nil)
    } else {
      guard let classToAdd = self.classToAdd else { return }
      let classData: Dictionary<String, Any>
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
      let classDateAndTimeSet = dateFormatter.string(from: datePicker.date)
      let timeStamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
      print("POO \(classDateAndTimeSet)")
      print("DAVID \(timeStamp)")
      
      classData = ["classDate": classDateAndTimeSet,
                                             "classLocation": classLocationTextField.text ?? "",
                                             "classDuration": classDurationTextField.text ?? "",
                                             "classAvailability": Int(classAvailabilityTextField.text!) ?? "",
                                             "classTimeStamp": timeStamp,
                                             "classDescription": classDescriptionTextField.text ?? "",
                                             "classLevel": classLevelTextField.text ?? ""]

       Database.database().reference().child("classes").child(classToAdd).childByAutoId().setValue(classData)
    
    
    self.dismiss(animated: true, completion: nil)
    
    
  }
  }
  
   @objc func handleBackFromClassVC() {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    view.addSubview(imageView)
    view.addSubview(backButton)
    view.addSubview(enterButton)
    view.addSubview(classAvailabilityTextField)
    view.addSubview(classDurationTextField)
    view.addSubview(classLocationTextField)
    view.addSubview(classDescriptionTextField)
    view.addSubview(classLevelTextField)
    view.addSubview(datePicker)
    
    classLevelTextField.anchor(top: classDescriptionTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 30)
    
    backButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 50, height: 50)
    
    enterButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 50, height: 50)
    
    imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
    
    classAvailabilityTextField.anchor(top: datePicker.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 30)
    
    classDurationTextField.anchor(top: classAvailabilityTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 30)
    
    classLocationTextField.anchor(top: classDurationTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 30)
    
    
    classDescriptionTextField.anchor(top: classLocationTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 300, height: 30)
    
    datePicker.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 150)
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
  }
  
}
