//
//  PrivateMessageViewController.swift
//  GymApplication1
//
//  Created by David on 29/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class PrivateMessageViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
  
  var messages = [PrivateMessage]()
  
  var user: User? {
    didSet {
      guard let userName = user?.username else { return }
      navigationItem.title = userName
      
      observeMessages()
    }
  }
  
  fileprivate func observeMessages() {
    guard let uid = Auth.auth().currentUser?.uid, let toUID = user?.uid else { return }
    let userMessageRef = Database.database().reference().child("userMessages").child(uid).child(toUID)
    

    userMessageRef.observe(.childAdded, with: { (snapshot) in
      let messageId = snapshot.key
      let messageRef = Database.database().reference().child("privateMessages").child(messageId)
      messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
        
        guard let dictionary = snapshot.value as? [String: Any] else { return }
        
        let message = PrivateMessage(dictionary: dictionary)
        print(message.text)
        
        if message.chatPartnerID() == self.user?.uid {
          self.messages.append(message)
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
          }
        }

      }, withCancel: { (err) in
        print(err)
      })

    }) { (err) in
      print(err)
    }
    
  }
  
  lazy var textField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter message..."
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.delegate = self
    return tf
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
    button.addTarget(self, action: #selector(handleExitFromPrivateMessageUserController), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.hidesBarsOnSwipe = true
    collectionView?.keyboardDismissMode = .interactive
    
    collectionView?.register(PrivateMessageView.self, forCellWithReuseIdentifier: "cellId")
    collectionView?.alwaysBounceVertical = true
    collectionView?.contentInset = UIEdgeInsetsMake(8, 0, 58, 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
    
    view.addSubview(exitButton)
    
    setupInputComponents()

    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 58, paddingRight: 0, width: 50, height: 50)
    
    //observePrivateMessages()
    //observeUserMessages()
    
  }
  
  var containerViewBottomAnchor: NSLayoutConstraint?
  
  func setupInputComponents() {
    let containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = .white
    
    view.addSubview(containerView)
    
    containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    containerViewBottomAnchor?.isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    
    let sendBtn = UIButton(type: .system)
    sendBtn.setTitle("Send", for: .normal)
    sendBtn.translatesAutoresizingMaskIntoConstraints = false
    sendBtn.setTitleColor(.black, for: .normal)
    sendBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    sendBtn.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    containerView.addSubview(sendBtn)
    
    sendBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    sendBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    sendBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
    sendBtn.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    
    containerView.addSubview(textField)
 
    textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    textField.rightAnchor.constraint(equalTo: sendBtn.leftAnchor).isActive = true
    textField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1).isActive = true
    
    let seperatorLineView = UIView()
    seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
    seperatorLineView.backgroundColor = .red
    seperatorLineView.alpha = 0.6
    seperatorLineView.layer.cornerRadius = 5
    seperatorLineView.layer.shadowColor = UIColor.black.cgColor
    seperatorLineView.layer.shadowOpacity = 0.2
    seperatorLineView.layer.shadowOffset = CGSize(width: 1, height: 1)
    seperatorLineView.layer.shadowRadius = 1
    containerView.addSubview(seperatorLineView)
    
    seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    seperatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
    seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PrivateMessageView
    
    let message = messages[indexPath.item]
    cell.messageview.text = message.text

    setupCell(cell: cell, message: message)
    cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message.text).width + 20
    return cell
  }
  
  fileprivate func setupCell(cell: PrivateMessageView, message: PrivateMessage) {
    guard let imageUrl = self.user?.profileImageUrl else { return }
    cell.userProfileImageView.loadImage(urlString: imageUrl)
    if message.fromUID == Auth.auth().currentUser?.uid {
      // ioutgoing of red
      cell.bubbleView.backgroundColor = UIColor.red
      cell.messageview.textColor = .white
      cell.bubbleView.alpha = 0.6
      cell.userProfileImageView.isHidden = true
      cell.bubbleViewLeftAnchor?.isActive = false
      cell.bubbleViewRightAnchor?.isActive = true
    } else {
      // incoming of dark gray
      cell.bubbleView.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
      cell.messageview.textColor = .black
      cell.bubbleViewRightAnchor?.isActive = false
      cell.bubbleViewLeftAnchor?.isActive = true
      cell.userProfileImageView.isHidden = false
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
    let dummyCell = PrivateMessageView(frame: frame)
    dummyCell.privateMessages = messages[indexPath.item]
    dummyCell.layoutIfNeeded()
    
    let targetSize = CGSize(width: view.frame.width, height: 70)
    let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
    let height = max(50, estimatedSize.height)
    
    return CGSize(width: view.frame.width, height: height)
  }
  
  fileprivate func estimateFrameForText(text: String) -> CGRect {
    let size = CGSize(width: 200, height: 1000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16)], context: nil)
  }

  @objc func handleExitFromPrivateMessageUserController() {
    self.navigationController?.popViewController(animated: true)
  }

  fileprivate func observeUserMessages() {
    guard let uid = Auth.auth().currentUser?.uid else { return }

    let ref = Database.database().reference().child("userMessages").child(uid)
    ref.observe(.childAdded) { (snapshot) in

      print("YRYRY \(snapshot)")
      print(snapshot.key)

      let messageID = snapshot.key
      let messageRef = Database.database().reference().child("privateMessages").child(messageID)

      messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
        print("HAHAHA \(snapshot.value)")
        
        // uSER WITHIN vc - NOT LOGGED IN USER
        // Need to do a check to see if the from or toID is this user.uid otherwise, display nothing!!!!

        print("CATHY \(snapshot.key)")
        print(self.user?.uid)
        guard let dictionary = snapshot.value as? [String: Any] else { return }
        
        
        self.messages.append(PrivateMessage(dictionary: dictionary))
        DispatchQueue.main.async {
          self.collectionView?.reloadData()
        }

      }, withCancel: { (err) in
        print("Failed to fetch users messages", err)
        return
      })

    }

  }

  @objc func handleSendMessage() {
    let ref = Database.database().reference().child("privateMessages")
    guard let text = textField.text else { return }
    guard let toUserUID = user?.uid else { return }
    guard let fromUID = Auth.auth().currentUser?.uid else { return }
    
    let messageDate = NSNumber(value: Int(Date().timeIntervalSince1970))
    
    let values = ["text": text,
                  "userUID": toUserUID,
                  "fromUID": fromUID,
                  "messageDate": messageDate] as [String : Any]
    
    let childRef = ref.childByAutoId()

    childRef.updateChildValues(values) { (err, ref) in
      if err != nil {
        print(err)
        return
      }
      self.textField.text = nil
      self.updateMessageNodeInFirebase(childRef: childRef, fromUID: fromUID, toUID: toUserUID)
    }
  
  }
  
  fileprivate func updateMessageNodeInFirebase(childRef: DatabaseReference, fromUID: String, toUID: String) {
    let userMessageRef = Database.database().reference().child("userMessages").child(fromUID).child(toUID)
    let messageID = childRef.key
    userMessageRef.updateChildValues([messageID: 1])
    
    self.updateMessageNodeInFirebaseWithToUID(messageID: messageID, toUID: toUID, fromID: fromUID)
  }
  
  fileprivate func updateMessageNodeInFirebaseWithToUID(messageID: String, toUID: String, fromID: String) {
    let recipientMessageRef = Database.database().reference().child("userMessages").child(toUID)
    recipientMessageRef.updateChildValues([messageID: 1])
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    handleSendMessage()
    return true
  }
  
}
