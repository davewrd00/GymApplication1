//
//  ShareFeedViewController.swift
//  GymApplication1
//
//  Created by David on 23/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class ShareFeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var imageSetForPost: UIImage?
  
  let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), for: .normal)
    button.imageView?.contentMode = .scaleAspectFill
    button.translatesAutoresizingMaskIntoConstraints = false
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
    return button
  }()
  
  let textView: UITextView = {
    let tv = UITextView()
    tv.layer.borderColor = UIColor.black.cgColor
    tv.layer.borderWidth = 2
    tv.layer.cornerRadius = 5
    tv.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
    return tv
  }()
  
  let submitButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("Submit post", for: .normal)
    btn.addTarget(self, action: #selector(handleSubmitPost), for: .touchUpInside)
    btn.backgroundColor = .green
    btn.layer.cornerRadius = 5
    btn.layer.shadowColor = UIColor.black.cgColor
    btn.layer.shadowOpacity = 0.2
    btn.layer.shadowOffset = CGSize(width: 1, height: 1)
    btn.layer.shadowRadius = 1
    btn.alpha = 0.6
    btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
    return btn
  }()
  
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
    button.addTarget(self, action: #selector(handleExitFromSocialFeedVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(exitButton)
    view.addSubview(submitButton)
    
    submitButton.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 80)
    submitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    
    tabBarController?.tabBar.isHidden = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    setupImageAndTextViews()
    
  }
  
  @objc fileprivate func handlePlusPhoto() {
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
  
  
  fileprivate func setupImageAndTextViews() {
    
    let containerView = UIView()
    containerView.backgroundColor = .white
    
    view.addSubview(containerView)
    
    
    containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250)
    
    containerView.addSubview(plusPhotoButton)
    plusPhotoButton.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 90, height: 90)
    plusPhotoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    
    containerView.addSubview(textView)
    textView.anchor(top: plusPhotoButton.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    
    
  }
  
  @objc fileprivate func handleExitFromSocialFeedVC() {
    self.navigationController?.popViewController(animated: true)
    
  }
  
  @objc fileprivate func handleSubmitPost() {
    print(123)
    
    guard let caption = textView.text, caption.characters.count > 0 else { return }
    guard let image = plusPhotoButton.imageView?.image else { return }
    guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
    
    let fileName = NSUUID().uuidString
    Storage.storage().reference().child("posts").child(fileName).putData(uploadData, metadata: nil) { (metadata, err) in
      if let err = err {
        print("Failed to upload post image", err)
      }
      guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
      
      print("Successfully been able to post image", imageUrl)
      
      self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
    }
  }
  
  fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
    
    guard let caption = textView.text else { return }
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let postImage = plusPhotoButton.imageView?.image else { return }
    
    let userPostRef = Database.database().reference().child("posts").child(uid)
    let ref = userPostRef.childByAutoId()
    
    let values = ["imageUrl": imageUrl,
                  "caption": caption,
                  "imageWidth": postImage.size.width,
                  "imageHeight": postImage.size.height,
    "creationDate": Date().timeIntervalSince1970] as [String: Any]
    
    ref.updateChildValues(values) { (err, ref) in
      if let err = err {
        print("Failed to save post to DB")
        return
      }
      print("Successfully been able to save the post to the database")
      let mainTabBarVC = TabBarController()
      self.present(mainTabBarVC, animated: true, completion: nil)
    }
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
