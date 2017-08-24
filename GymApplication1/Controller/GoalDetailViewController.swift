//
//  GoalDetailViewController.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class GoalDetailViewController: UIViewController {
  
  var user: User? {
    didSet {
      print("PAUL: \(user?.userPointsEarned ?? 0)")
      pointsAlreadyEarned = user?.userPointsEarned
      
    }
  }
  
  var goalsCompleted: GoalsCompleted?
  
  var pointsAlreadyEarned: Int?
  
  var goal: Goals? {
    didSet {
      goalNameLabel.text = goal?.goalName
      goalDescriptionLabel.text = goal?.goalDescription
      print("DODO \(goal?.goalUID ?? 0)")
      setupGoalImage()
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
    let image = UIImage(named: "back_btn")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleExitFromClassVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  let acceptButton: UIButton = {
    let b = UIButton(type: .custom)
    b.backgroundColor = .green
    b.alpha = 0.6
    b.layer.cornerRadius = 5
    b.clipsToBounds = true
    b.contentMode = .scaleAspectFill
    let image = UIImage(named: "tick")
    b.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    b.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
    return b
  }()
  
  let imageViewOfGoal: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    return iv
  }()
  
  let goalNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
    lbl.textColor = .black
    return lbl
  }()
  
  let goalDescriptionBox: UIView = {
    let v = UIView()
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOffset = CGSize(width: 8, height: 12)
    v.layer.shadowOpacity = 0.4
    v.backgroundColor = .white
    v.layer.shadowRadius = 5.0
    v.layer.cornerRadius = 5
    return v
  }()
  
  let goalDescriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    return lbl
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    print("PAP \(self.user?.userPointsEarned)")
    print("DAVIDWARD: \(pointsAlreadyEarned)")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.isHidden = true
    self.tabBarController?.tabBar.isHidden = true
    
    view.addSubview(exitButton)
    view.addSubview(imageViewOfGoal)
    view.addSubview(goalNameLabel)
    view.addSubview(acceptButton)
    view.addSubview(goalDescriptionBox)
    view.addSubview(goalDescriptionLabel)
    
    imageViewOfGoal.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 300)
    
    goalDescriptionBox.anchor(top: imageViewOfGoal.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 300, height: 100)
    
    goalDescriptionLabel.anchor(top: goalDescriptionBox.topAnchor, left: goalDescriptionBox.leftAnchor, bottom: goalDescriptionBox.bottomAnchor, right: goalDescriptionBox.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    goalNameLabel.anchor(top: imageViewOfGoal.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    goalNameLabel.centerYAnchor.constraint(equalTo: imageViewOfGoal.centerYAnchor).isActive = true
    goalNameLabel.centerXAnchor.constraint(equalTo: imageViewOfGoal.centerXAnchor).isActive = true
    
    acceptButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 50, height: 50)
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
   
    
    //fetchUser()
  }
  
//  func fetchUserPoints() {
//    print("Fetching points for user")
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    guard let userPoints = user?.userPointsEarned else { return }
//    Database.database().reference().child("users").child(uid).child("pointsEarned").observeSingleEvent(of: .value) { (snapshot) in
//      print("DAVID2: \(snapshot.value ?? "")")
//
//    }
//
//  }
  
  
  @objc func handleExitFromClassVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func handleAddGoal() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let goalPoints = self.goal?.goalPoints else { return }
    Database.database().reference().child("users").child(uid).child("pointsEarned").observeSingleEvent(of: .value, with: { (snapshot) in
      
      if let pointsEarned = snapshot.value {
        print("STEVE \(pointsEarned)")
        
        self.handleCompletedGoal()
        self.updateTotalNumberOfPointsEarned(uid: uid, goalPoints: goalPoints) {
          print("Updated")
        }
      }
      
    }) { (err) in
      print(err.localizedDescription)
    }
  }
  
  fileprivate func updateTotalNumberOfPointsEarned(uid: String, goalPoints: Int, completionBlock: @escaping (() -> Void)) {
    let ref = Database.database().reference().child("users").child(uid).child("pointsEarned")
    
    ref.runTransactionBlock({ (result) -> TransactionResult in
      if let initialValue = result.value as? Int {
        print("STEVE \(initialValue)")
        result.value = initialValue + goalPoints
        print("STEVE \(goalPoints)")
        return TransactionResult.success(withValue: result)
      } else {
        return TransactionResult.success(withValue: result)
      }
    }) { (err, completion, snap) in
      print(err?.localizedDescription ?? "")
      print(completion)
      print(snap ?? "")
      if !completion {
        print("Couldnt update this node")
      } else {
        completionBlock()
      }
    }
  }
  
  var goalsComplete = [GoalsCompleted]()
  
  fileprivate func handleCompletedGoal() {
    guard let goalName = goal?.goalName else { return }
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let goalUID = goal?.goalUID else { return }
    
    let values = ["goalName": goalName] as [String: Any]
    
    Database.database().reference().child("goalsCompleteByUser").child(uid).child("\(goalUID)").updateChildValues(values) { (err, ref) in
      if let err = err {
        print("Failed to store the goal the user just completed into Firebase Database")
        return
      }
      print("Successfully stored this completed goal into database")
 
      self.dismiss(animated: true, completion: nil)
    }
    
  }

  func setupGoalImage() {
    guard let goalImageUrl = goal?.goalImageUrl else { return }
    
    guard let url = URL(string: goalImageUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for the error and then construct the image using the data
      if let err = err {
        print("Failed to fetch profile image:", err)
        return
      }
      
      guard let data = data else { return }
      
      let image = UIImage(data: data)
      
      DispatchQueue.main.async {
        self.imageViewOfGoal.image = image
      }
      
      }.resume()
  
  }
}
