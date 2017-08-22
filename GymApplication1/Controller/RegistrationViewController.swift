//
//  RegistrationViewController.swift
//  GymApplication1
//
//  Created by David on 10/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  let backgroundView: UIView = {
    let view = UIView()
    let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "gym"))
    backgroundImage.contentMode = .scaleAspectFill
    view.addSubview(backgroundImage)
    let overView = UIView()
    overView.backgroundColor = UIColor(white: 0.2, alpha: 0.6)
    view.addSubview(overView)
    overView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    return view
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
  
  let nameTextField: UITextField = {
    let tf = UITextField()
    
    tf.leftViewMode = UITextFieldViewMode.always
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let image = UIImage(named: "name")
    imageView.image = image
    tf.leftView = imageView
    
    tf.backgroundColor = .clear
    tf.textColor = .white
    tf.attributedPlaceholder = NSAttributedString(string: "   NAME", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderColor = UIColor.white.cgColor
    tf.layer.borderWidth = 1
    tf.layer.cornerRadius = 8
    tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    
    tf.leftViewMode = UITextFieldViewMode.always
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let image = UIImage(named: "email-1")
    imageView.image = image
    tf.leftView = imageView
    
    tf.backgroundColor = .clear
    tf.textColor = .white
    tf.attributedPlaceholder = NSAttributedString(string: "   EMAIL", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderColor = UIColor.white.cgColor
    tf.layer.borderWidth = 2
    tf.layer.cornerRadius = 8
    tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    
    tf.leftViewMode = UITextFieldViewMode.always
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let image = UIImage(named: "password")
    imageView.image = image
    tf.leftView = imageView
    
    tf.backgroundColor = .clear
    tf.textColor = .white
    tf.isSecureTextEntry = true
    tf.attributedPlaceholder = NSAttributedString(string: "   PASSWORD", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderColor = UIColor.white.cgColor
    tf.layer.borderWidth = 2
    tf.layer.cornerRadius = 8
    tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let signupButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.rgb(red: 94, green: 186, blue: 125)
    let attributedText = NSMutableAttributedString(string: "SIGN UP", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    button.setAttributedTitle(attributedText, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.white.cgColor
    button.isEnabled = false
    button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
    return button
  }()
  
  let swicthToLoginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    let attributedText = NSMutableAttributedString(string: "Alread have an account? ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.white])
    attributedText.append(NSMutableAttributedString(string: "Login", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.red]))
    button.setAttributedTitle(attributedText, for: .normal)
    button.addTarget(self, action: #selector(switchToWelcomeView), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    nameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    
    view.addSubview(backgroundView)
    view.addSubview(plusPhotoButton)
    view.addSubview(nameTextField)
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(signupButton)
    view.addSubview(swicthToLoginButton)
    
    
    backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    
    plusPhotoButton.heightAnchor.constraint(equalToConstant: 240).isActive = true
    plusPhotoButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
    plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    
    nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    nameTextField.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20).isActive = true
    
    emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
    
    passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
    
    signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    signupButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    
    swicthToLoginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    swicthToLoginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    swicthToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    swicthToLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
  }
  
  @objc func switchToWelcomeView() {
    dismiss(animated: true, completion: nil)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
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
  
  @objc fileprivate func handleTextInputChange() {
    let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && nameTextField.text?.characters.count ?? 0 > 0 && passwordTextField.text?.characters.count ?? 0 > 0
    
    if isFormValid {
      signupButton.isEnabled = true
      signupButton.backgroundColor = UIColor.rgb(red: 94, green: 186, blue: 125)
    } else {
      signupButton.isEnabled = false
      signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
  }
  
  @objc fileprivate func handleRegistration() {
    guard let email = emailTextField.text, email.characters.count > 0 else { return }
    guard let name = nameTextField.text, name.characters.count > 0 else { return }
    guard let password = passwordTextField.text, password.characters.count > 0 else { return }
    
    Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
      if let _ = err {
        print("Unable to create a new user")
        return
      }
      print("Succcessfully been able to create a new user", user?.uid ?? "")
      
      guard let image = self.plusPhotoButton.imageView?.image else { return }
      
      guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
      
      let filename = NSUUID().uuidString
      Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
        if let err = err {
          print("Failed to upload profile image", err)
          return
        }
        
        guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
        print("Successfully uplaoded profile image URL")
        
        guard let uid = user?.uid else { return }
        
        let dictionaryValues: [String: Any] = ["username": name,
                                "profileImageURL": profileImageUrl,
                                "pointsEarned": 0]
        let values = [uid: dictionaryValues]
        
        Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
          if let err = err {
            print("Failed to save user info to DB:", err)
            return
          }
          print("Successfully saved the newly registered user into the DB")
          
          // For now, lets just segue to the new blue screen that is the home screen
          let tabBarController = TabBarController()
          self.present(tabBarController, animated: true, completion: nil)
        })
      })
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
