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
    
    if goalsCompleted.contains(self.goalUID!) {
      print("Hell Yea")
      self.goals.remove(at: indexPath.item)
      collectionView.reloadData()
      return cell
    } else {
      cell.goals = goals[indexPath.item]
      return cell
    }
    
    
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
    
    //print("STEVE \(toggledCompletion)")
    
    if toggledCompletion {
      print("STEVE: Goal is true")
      cell.backgroundColor = .green
      cell.isUserInteractionEnabled = false
    } else {
      cell.backgroundColor = .white
    }
    
    let goalPicked = goals[indexPath.item]
    print(goalPicked.goalName, goalPicked.goalDescription)
    
    let goalDetailVC = GoalDetailViewController()
    goalDetailVC.goal = goalPicked
    navigationController?.pushViewController(goalDetailVC, animated: true)
  }
  
  var goalUID: Int?
  
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
        
        guard let goalDictionary = value as? [String: Any] else { return }
        let goals = Goals(userUid: uid, dictionary: goalDictionary)
        self.goals.append(goals)
        print("DAVIDPOO: \(goals)")
        
        print("DAVIDPOO \(goals.goalUID)")
        self.goalUID = goals.goalUID
//        if self.goalsCompleted.contains(self.goalUID!) {
//          print("Hell Yeah")
//        // Remove that value from FB
//
//
//        }
        
        // Need to now do a check to see if any of these goals have been achieved, and if so must ensure that the
        // collectionView is updated with this info
        
        
      })
      
      self.collectionView?.reloadData()
      
    }
  }
  
  func seeIfGoalComplete(goalUID: Int) {
    Database.database().reference().child("goalsCompletedByUser").observeSingleEvent(of: .value, with: { (snapshot) in
      if snapshot.hasChild("\(goalUID)") {
        print("This exists")
      } else {
        print("This UID does not exist")
      }
    }) { (err) in
      print("Error fetching goals complete", err)
      return
    }
  }
  
  var goalsCompleted = [Int]()
  
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
        
        if snapshot.hasChild(key) {
          print("Goal completed")
        } else {
          print("Nothiung")
        }
        
        guard let goalCompleteDict = value as? [String: Any] else { return }
        let goalComp = GoalsCompleted(goalUID: intKey, dictionary: goalCompleteDict)
        self.goalsCompleted.append(intKey)
        self.goalUID = intKey
        print("CATHERINE \(goalComp)")
      })
      
      self.collectionView?.reloadData()
    }) { (err) in
      print("Unable to download goals that this user has completed")
      return
    }
  }
  
  
  
  
}

