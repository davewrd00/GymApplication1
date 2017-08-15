//
//  ViewController.swift
//  GymApplication1
//
//  Created by David on 09/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class WelcomeViewController: UIViewController {
  
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
  
  let textView: UITextView = {
    let tv = UITextView()
    let attributedTitle = NSMutableAttributedString(string: "Welcome to the Nuffield App", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 40), NSAttributedStringKey.foregroundColor: UIColor.white])
    tv.backgroundColor = .clear
    tv.attributedText = attributedTitle
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()
  
  let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    let attributedText = NSMutableAttributedString(string: "Login", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    button.setAttributedTitle(attributedText, for: .normal)
    button.layer.cornerRadius = 8
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 2
    return button
  }()
  
  let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    let attributedText = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
    button.setAttributedTitle(attributedText, for: .normal)
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    button.layer.cornerRadius = 8
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.white.cgColor
    return button
  }()
  
  let fbLoginBtn: FBSDKLoginButton = {
    let button = FBSDKLoginButton()
    button.readPermissions = ["email"]
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(facebookBtnPressed), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //setBlurEffect()
    setupViews()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if let _ = KeychainWrapper.standard.string(forKey: "uid") {
      print("ID found in keychain")
      let homeVC = HomeViewController()
      self.present(homeVC, animated: true, completion: nil)
    }
    
    self.navigationController?.isNavigationBarHidden = true
  }
  
  func setupViews() {
    view.addSubview(backgroundView)
    view.addSubview(fbLoginBtn)
    view.addSubview(textView)
    view.addSubview(loginButton)
    view.addSubview(signUpButton)
    
    backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    
    textView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    textView.widthAnchor.constraint(equalToConstant: 240).isActive = true
    textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    
    fbLoginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    fbLoginBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
    fbLoginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    fbLoginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
    
    loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginButton.bottomAnchor.constraint(equalTo: fbLoginBtn.topAnchor, constant: -20).isActive = true
    
    signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    signUpButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    signUpButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20).isActive = true
  }
  
  // This function adds the blureffect should I want to use it
//  fileprivate func setBlurEffect() {
//    // Do any additional setup after loading the view.
//    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
//    let blurEffectView = UIVisualEffectView(effect: blurEffect)
//    blurEffectView.frame = view.bounds
//    backgroundView.addSubview(blurEffectView)
//  }
  
  @objc func handleLogin() {
    print(123)
    let loginVC = LoginViewController()
    self.present(loginVC, animated: true, completion: nil)
  }
  
  @objc func handleSignUp() {
    print("David")
    let registerVC = RegistrationViewController()
    self.present(registerVC, animated: true, completion: nil)
  }
  
  @objc func handleFacebookLogin() {
    print("Catherine")
  }
  
  @objc func facebookBtnPressed() {
    let fbLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
      if error != nil {
        print("Error logging in with Facebook")
        return
      }
      guard let accessToken = FBSDKAccessToken.current() else {
        print("Failed to get the access token")
        return
      }
      
      let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
      
      // Perform login by calling Firebas API
      Auth.auth().signIn(with: credential, completion: { (user, error) in
        if let error = error {
          print("Login error: \(error.localizedDescription)")
          let alertController = UIAlertController(title: "Login error", message: "Error is \(error.localizedDescription)", preferredStyle: .alert)
          let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okayAction)
          self.present(alertController, animated: true, completion: nil)
        } else {
          if user != nil {
            //self.loginVC.completeSignIn(id: user.uid)
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: true)
            
          }
        }
      })
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

