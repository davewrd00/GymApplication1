//
//  Extensions.swift
//  GymApplication1
//
//  Created by David on 09/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit


extension UIColor {
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  static func mainBlue() -> UIColor {
    return UIColor.rgb(red: 17, green: 154, blue: 237)
  }
  
}


extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if width != 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
}

extension UIView{
  func addConstraintsWithFormat(format:String, views:UIView...){
    var viewsDictionary = [String:UIView]()
    
    for(index, view) in views.enumerated(){
      let key:String = "v\(index)"
      
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
      
      
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    
  }
}

//
//  @objc func handleAddGoal() {
//    guard let goalName = goal?.goalName else { return }
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    guard let goalPoints = goal?.goalPoints else { return }
//
//    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
//    let alertView = SCLAlertView(appearance: appearance)
//    alertView.showSuccess("Started \(goalName)!", subTitle: "Good luck!", duration: 1.5)
//
//    var goalAchieved: Bool = true
//
//    let goalClicked: Dictionary<String, Any>
//    goalClicked = ["goalName": self.goal?.goalName ?? "",
//                   "goalPoints": self.goal?.goalPoints ?? "",
//                   "goalAchieved": goalAchieved]
//
//    //let updateGoal = GoalCompleted(goalName: goalName, goalPoints: goalPoints, goalAchieved: true)
//
//
//
//    // This add the completed goal to the users UID in Firebase so to keep track of all goals completed by the user, evenatually so that
//    // the collectionView will then remove those which the user has completed by using the child node goalName
//    Database.database().reference().child("users").child(uid).child("goalsCompleted").child(goalName).setValue(goalClicked) { (err, ref) in
//
//      if err != nil {
//        print("Unable to upload the goal to user Firebase DB")
//        return
//      }
//
//
//      // If the function has been successful this is where you need to then update the pointsEarned node to show the points the user
//      // has earned!
//
//      guard let pointsAlreadyEarned = self.user?.userPointsEarned else { return }
//
//      var updatedPoints: Int = goalPoints
//
//
//      Database.database().reference().child("users").child(uid).updateChildValues(["pointsEarned": goalPoints])
//
//      // We then need observe all OF THE USERS DATA AT ROOT NODE TO THEN UPDATE OUR USER MODEL
////      Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
////        print(snapshot.value ?? "")
////
////
////
////        // Need some form of logic here to add on the initial value stored in user?.userPoints so the new one, updating the user model with this so that
////        // the views can be updated
////
////        // Create the dictionary of all values
////        guard let dict = snapshot.value as? [String: Any] else { return }
////
////        // This initializes the user model using the above Dictionary, overwriting the initial data
////        self.user = User(dictionary: dict)
////
////        self.pointsAlreadyEarned = self.user?.userPointsEarned
////
////        print("DAVIDDAVID \(self.pointsAlreadyEarned)")
////        print("FAN \(self.user?.userPointsEarned)")
////
////
////      }, withCancel: { (err) in
////        if err == nil {
////          print("No issues", err)
////        }
////      })
//
//    }
//
//  }
//






