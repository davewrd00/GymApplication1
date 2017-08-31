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

enum AchievementBoundaries: Int {
  case Bronze = 1000
  case Silver = 2500
  case Gold = 5000
  case Veteran = 10000
  case Professional = 12500
  case Olympian = 15000
}

class GoalsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var hasAchievedBronze = false
  var hasAchievedSilver = false
  var hasAchievedGold = false
  var hasAchievedVeteran = false
  var hasAchievedProfessional = false
  var hasAchievedOlympian = false
  
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
  
  var achievement: Achievements? {
    didSet {
      print("Gotten all the achievements")
      print("Achievement name \(achievement?.achievementName)")
    }
  }
  
  var achievementsEarned = [AchievementsEarned]() {
    didSet {
      print("Setting a goal since its been completed")
    }
  }
  
  
  var user: User? {
    didSet {
      guard let userPoints = user?.userPointsEarned else { return }
      print("LARRY \(userPoints)")
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
    fetchAchievements()
    fetchCompleteAchievements()
    
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
  
  func fetchCompleteGoals() {
    guard let userUID = Auth.auth().currentUser?.uid else { return }
    
    DataService.sharedInstance.fetchCompoletedGoals(uid: userUID) { (goalComplete, goalUID) in
      self.arrayOfGoalsCompleted.append(goalUID)
      self.goalsComplete.append(goalComplete)
    }
    self.collectionView?.reloadData()
    
  }
  
  func fetchGoals() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let ref = Database.database().reference().child("goals")
    ref.observeSingleEvent(of: .value) { (snapshot) in
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
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
        self.arrayOfGoalUID.append(goals.goalUID)
        if goals.goalCompleted == true {
          print("This is true")
        }
      })
      
      self.collectionView?.reloadData()
  
    }
  }
  
  fileprivate func fetchAchievements() {
    
    DataService.sharedInstance.fetchAchievementsFromFirebase { (achievement) in
      self.achievement = achievement
    }
  }
  
  fileprivate func fetchCompleteAchievements() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    DataService.sharedInstance.fetchAchievementsEarnedByUser(uid: uid) { (key) in
      print("ACHUEI \(key)")
      if key == "bronze" {
        self.hasAchievedBronze = true
      } else if key == "silver" {
        self.hasAchievedSilver = true
      } else if key == "gold" {
        self.hasAchievedGold = true
      } else if key == "Veteran" {
        self.hasAchievedVeteran = true
      } else if key == "professional" {
        self.hasAchievedProfessional = true
      } else if key == "olympian" {
        self.hasAchievedOlympian = true
      }
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
      
      self.updateTotalNumberOfPointsEarned(uid: uid, goalPoints: goal.goalPoints)
      
      self.getPoints()
    }
  }
  
  fileprivate func updateTotalNumberOfPointsEarned(uid: String, goalPoints: Int) {
    DataService.sharedInstance.updatePoints(path: "users", uid: uid, newValue: goalPoints) { (points) in
      print("POOOOINTS \(points)")
      self.seeIfAchievementHasBeenMet(userPoints: points)
    }
  }
  
  fileprivate func getPoints() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    print("Getting these points...")
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
    }) { (err) in
      print("Error", err)
    }
  }
  
  func seeIfAchievementHasBeenMet(userPoints: Int) {
    print("The points that this user has is \(userPoints)")
    
    if userPoints >= 1000 && userPoints <= 2499 && hasAchievedBronze == false {
      let achievementName = "bronze"
      let alertCont = UIAlertController(title: "Wooo!!!!", message: "You have achieved your first medal!", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Accept?", style: .cancel, handler: { (action) in
        self.doSomething(achievementName: achievementName)
      })
      alertCont.addAction(okayAction)
      self.present(alertCont, animated: true, completion: nil)
      hasAchievedBronze = true
      
    } else if userPoints >= 2500 && userPoints <= 4999 && hasAchievedSilver == false {
      let achievementName = "silver"
      let alertCont = UIAlertController(title: "Wooo!!!!", message: "You have achieved your second medal!", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Accept?", style: .cancel, handler: { (action) in
        self.doSomething(achievementName: achievementName)
      })
      alertCont.addAction(okayAction)
      self.present(alertCont, animated: true, completion: nil)
      print("2500 or over")
      hasAchievedSilver = true
      
    } else if userPoints >= 5000 && userPoints <= 9999  && hasAchievedGold == false {
      let achievementName = "gold"
      let alertCont = UIAlertController(title: "Wooo!!!!", message: "You have achieved your third medal!", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Accept?", style: .cancel, handler: { (action) in
        self.doSomething(achievementName: achievementName)
      })
      alertCont.addAction(okayAction)
      self.present(alertCont, animated: true, completion: nil)
      print("5000 or over")
      hasAchievedGold = true
      
    } else if userPoints >= 10000 && userPoints <= 12499 && hasAchievedVeteran == false {
      let achievementName = "Veteran"
      let alertCont = UIAlertController(title: "Wooo!!!!", message: "You have achieved your fourth medal!", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Accept?", style: .cancel, handler: { (action) in
        self.doSomething(achievementName: achievementName)
      })
      alertCont.addAction(okayAction)
      self.present(alertCont, animated: true, completion: nil)
      print("10000 or over")
      hasAchievedVeteran = true
      
    } else if userPoints >= 12500 && userPoints <= 14999 && hasAchievedProfessional == false {
      let achievementName = "professional"
      let alertCont = UIAlertController(title: "Wooo!!!!", message: "You have achieved your fifth medal!", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Accept?", style: .cancel, handler: { (action) in
        self.doSomething(achievementName: achievementName)
      })
      alertCont.addAction(okayAction)
      self.present(alertCont, animated: true, completion: nil)
      print("12500 points and over")
      hasAchievedProfessional = true
      
    } else if userPoints >= 15000 && hasAchievedOlympian == false {
      let achievementName = "olympian"
      let alertCont = UIAlertController(title: "Amazing!!!!", message: "All medals have been achieved!", preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Accept?", style: .cancel, handler: { (action) in
        self.doSomething(achievementName: achievementName)
      })
      alertCont.addAction(okayAction)
      self.present(alertCont, animated: true, completion: nil)
      print("Maximum amount left")
      hasAchievedOlympian = true
    }
  }
  
  func doSomething(achievementName: String) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let values = ["achievementName": achievementName,
                  "hasAchieved": true] as [String : Any]
    
    Database.database().reference().child("achievementsEarnedByUser").child(uid).child(achievementName).setValue(values) { (err, ref) in
      print("Error doing this", ref)
    }
  }
  
}
