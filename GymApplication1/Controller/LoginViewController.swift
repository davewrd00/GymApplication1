//
//  LoginViewController.swift
//  GymApplication1
//
//  Created by David on 10/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase
import SwiftKeychainWrapper

class LoginViewController: UIViewController, UITextFieldDelegate {
  
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
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    
    tf.leftViewMode = UITextFieldViewMode.always
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let image = UIImage(named: "email-1")
    imageView.image = image
    tf.leftView = imageView
    
    tf.backgroundColor = .clear
    tf.textColor = .white
    tf.attributedPlaceholder = NSAttributedString(string: "   USERNAME", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.layer.borderColor = UIColor.white.cgColor
    tf.layer.borderWidth = 2
    tf.layer.cornerRadius = 8
    tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
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
    return tf
  }()
  
  let switchToRegisterView: UIButton = {
    let button = UIButton()
    button.backgroundColor = .clear
    button.translatesAutoresizingMaskIntoConstraints = false
    let attributedText = NSMutableAttributedString(string: "Not registered? ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.white])
    attributedText.append(NSMutableAttributedString(string: "Register now!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.red]))
    button.setAttributedTitle(attributedText, for: .normal)
    button.addTarget(self, action: #selector(switchToWelcomeView), for: .touchUpInside)
    return button
  }()
  
  let loginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.rgb(red: 94, green: 186, blue: 125)
    let attributedText = NSMutableAttributedString(string: "LOGIN", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    button.setAttributedTitle(attributedText, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.white.cgColor
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    setupViews()
  }
  
  @objc func switchToWelcomeView() {
    dismiss(animated: true, completion: nil)
  }
  
  func setupViews() {
    view.addSubview(backgroundView)
    view.addSubview(emailTextField)
    view.addSubview(switchToRegisterView)
    view.addSubview(passwordTextField)
    view.addSubview(loginButton)
    
    backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    
    emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    
    passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
    
    loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60).isActive = true
    
    switchToRegisterView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    switchToRegisterView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    switchToRegisterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    switchToRegisterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  @objc fileprivate func handleLogin() {
    
    if let email = emailTextField.text, let password = passwordTextField.text {
      Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
        if err == nil {
          print("Users email authenticated with Firebase")
          if let user = user {
//            if user.uid == "vAOe4JijoDYO8jTD7TCwceo4qcs2" {
              self.completeSignIn(id: user.uid)
            print("DAVIDPOO \(user.uid)")
//              let adminVC = AdminViewController()
//              self.present(adminVC, animated: true, completion: nil)
             // self.completeSignIn(id: user.uid)
//            }
            
          }
          
        } else {
          self.displayAlert(title: "Error logging into system", message: "Login details are incorrect. Please try again", actionTitle: "OK")
          
        }
      })
    }
    
    
  }
  
  func completeSignIn(id: String) {
    let keychainResult = KeychainWrapper.standard.set(id, forKey: "uid")
    print("DAVID: Data saved to keychain \(keychainResult)")
    if id == "vAOe4JijoDYO8jTD7TCwceo4qcs2" {
      let tabBar = AdminTabBarController()
      self.present(tabBar, animated: true, completion: nil)
    } else {
      let mainTabBar = TabBarController()
      self.present(mainTabBar, animated: true, completion: nil)
    }
    
  }
  
  func displayAlert(title: String, message: String, actionTitle: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okayAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
    alertController.addAction(okayAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
  
  
}
