//
//  GoalsViewController.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import UICircularProgressRing
import Firebase

class GoalsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var goals = [Goals]()
  
  var goalsComplete = [GoalsCompleted]() {
    didSet {
      print("PLPEASE")
      print("How many ", goalsComplete.count)
      for item in goalsComplete {
        print("POOOOO \(item.goalName)")
      }
    }
  }
  
  var arrayOfGoalsCompleted = [Int]() {
    didSet {
      print("jaaaaa \(arrayOfGoalsCompleted.count)")
    }
  }
  var arrayOfGoalUID = [Int]() {
    didSet {
      print("paaaa \(arrayOfGoalUID.count)")
      for uid in arrayOfGoalUID {
        print("Paaaa \(uid)")
      }
    }
  }
  
  var newArrayOfGoals = [Int]()
  
  var goalUID: Int?
  
  var cell1 = "cellId"
  
  var cell2 = "cellId1"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(GoalsViewCell.self, forCellWithReuseIdentifier: cell1)
    collectionView?.register(GoalsViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
    fetchCompleteGoals()
     fetchGoals()
    
    
    
    
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell1, for: indexPath) as! GoalsViewCell
    
      cell.goals = goals[indexPath.item]
      return cell
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return goals.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 120)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! GoalsViewHeader
    
    return header
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 80)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    let goal = goals[indexPath.item]
    let toggledCompletion = !goal.goalCompleted
    
    if toggledCompletion {
      
      let alertController = UIAlertController(title: "Goal achieved!", message: "Completed this goal - points added", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
        self.handleCompletedGoal(goal: goal)
        
        cell.alpha = 0.2
        cell.isUserInteractionEnabled = false
      })
      alertController.addAction(okayAction)
      self.present(alertController, animated: true, completion: nil)
    } else {
      cell.backgroundColor = .white
    }
  }
  
  fileprivate func handleCompletedGoal(goal: Goals) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let goalPoints = goal.goalPoints
    
    let values = ["goalName": goal.goalName] as [String: Any]
    
    Database.database().reference().child("goalsCompleteByUser").child(uid).child("\(goal.goalUID)").updateChildValues(values) { (err, ref) in
      if let err = err {
        print("Failed to store the goal the user just completed into Firebase Database")
        return
      }
      print("Successfully stored this completed goal into database")
      
      self.updateTotalNumberOfPointsEarned(uid: uid, goalPoints: goalPoints) {
        print("Updated")
      }
      
      let tabBar = TabBarController()
      self.present(tabBar, animated: true, completion: nil)
    }
    
  }
  
  func fetchGoals() {
    print("Fetching the goals from FB")
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let ref = Database.database().reference().child("goals")
    ref.observeSingleEvent(of: .value) { (snapshot) in
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      print("DAVIDPOO: Fetching the goals \(dictionary)")
      
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        print(key)
        
        guard let intKey: Int = Int(key) else { return }
        guard let goalDictionary = value as? [String: Any] else { return }
        
        // Simply compares the uids in this array to see if this has been added - if so, the VC removes
        // this 
        if self.arrayOfGoalsCompleted.contains(intKey) {
          print("Found loads of completed goals")
          return
        }
        
        let goals = Goals(userUid: uid, dictionary: goalDictionary)
        self.goals.append(goals)
        print("JESSY \(goals)")
        
        self.arrayOfGoalUID.append(goals.goalUID)
        print("DAVIDPOO: \(goals)")
        if goals.goalCompleted == true {
          print("This is true")
        }
        
        print("DAVIDPOO \(goals.goalUID)")
        //self.goalUID = goals.goalUID
        
      })
      
      self.collectionView?.reloadData()
      
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
  
//  func seeIfGoalComplete(key: String) {
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    print("MAMY \(key)")
//    Database.database().reference().child("goalsCompleteByUser").child(uid).child(key).observeSingleEvent(of: .value, with: { (snapshot) in
//      print("Found these keys in the goals complete part of the FB")
//
//
//    }) { (err) in
//      print("Failed to find these keys in this part of the FB")
//    }
//  }
  
  
  
  func fetchCompleteGoals() {
    
    guard let userUID = Auth.auth().currentUser?.uid else { return }
    
    Database.database().reference().child("goalsCompleteByUser").child(userUID).observeSingleEvent(of: .value, with: { (snapshot) in
      
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      print("Fetching those completed goals ", dictionary)
      
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        guard let intKey = Int(key) else { return }
        print(key)
        print(value)
        
        guard let goalCompleteDict = value as? [String: Any] else { return }
        let goalComp = GoalsCompleted(goalUID: intKey, dictionary: goalCompleteDict)
        guard let goalUID = goalComp.goalUID as? Int else { return }
        self.arrayOfGoalsCompleted.append(goalUID)
        self.goalsComplete.append(goalComp)
        //self.goalUID = intKey
        print("CATHERINE \(goalComp)")
      })
      
      self.collectionView?.reloadData()
    }) { (err) in
      print("Unable to download goals that this user has completed")
      return
    }
  }
 
}

