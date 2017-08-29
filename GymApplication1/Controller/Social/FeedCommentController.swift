//
//  FeedCommentController.swift
//  GymApplication1
//
//  Created by David on 28/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class FeedCommentController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var post: Post?
  
  let cellId = "cellId"
  
  var comment = [Comment]()
  
  let commentTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter a comment"
    return tf
  }()
  
  lazy var containerView: UIView? = {
    let containerView = UIView()
    containerView.backgroundColor = .white
    containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
    
    let submitButton = UIButton(type: .system)
    submitButton.setTitle("Submit", for: .normal)
    submitButton.setTitleColor(.black, for: .normal)
    submitButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    submitButton.addTarget(self, action: #selector(handleSubmitComment), for: .touchUpInside)
    containerView.addSubview(submitButton)
    submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 0)
    
    containerView.addSubview(self.commentTextField)
    self.commentTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: submitButton.leftAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    
    
    
    return containerView
  
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
    button.addTarget(self, action: #selector(handleExitFromCommentsVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    collectionView?.register(SocialCommentCell.self, forCellWithReuseIdentifier: cellId)
    
    tabBarController?.tabBar.isHidden = true
    
    collectionView?.alwaysBounceVertical = true
    collectionView?.keyboardDismissMode = .interactive
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    fetchComments()
    
    view.addSubview(exitButton)
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 55, paddingRight: 0, width: 50, height: 50)
  }
  
  @objc func handleExitFromCommentsVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  fileprivate func fetchComments() {
    guard let postId = self.post?.id else { return }
    let ref = Database.database().reference().child("comments").child(postId)
    ref.observe(.childAdded, with: { (snapshot) in
      
      guard let commentsDict = snapshot.value as? [String: Any] else { return }
      guard let uid = commentsDict["uid"] as? String else { return }
      
      DataService.sharedInstance.fetchUserWithUID(uid: uid, completion: { (user) in
        let comment = Comment(user: user, dictionary: commentsDict)
        self.comment.append(comment)
        self.collectionView?.reloadData()
      })
      
      
    }) { (err) in
      print("Error fetching comments: ", err)
    }
  }
  
  @objc func handleSubmitComment() {
    print(123)
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let postId = self.post?.id ?? ""
    let values = ["text": commentTextField.text ?? "",
                  "creationDate": Date().timeIntervalSince1970,
                  "uid": uid] as [String: Any]
    
    Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
      if let err = err {
        print("Failed to insert a comment")
        return
      }
      print("Successfully been able to insert a comment")
    }
    
    
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comment.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.width, height: 80)
    
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
    let dummyCell = SocialCommentCell(frame: frame)
    dummyCell.comment = comment[indexPath.item]
    dummyCell.layoutIfNeeded()

    let targetSize = CGSize(width: view.frame.width, height: 1000)
    let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
    let height = max(50 + 8 + 8, estimatedSize.height)

    return CGSize(width: view.frame.width, height: height)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SocialCommentCell
    
    cell.comment = self.comment[indexPath.item]
  
    return cell
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return containerView
    }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  
}
