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
    collectionView?.register(GoalsUnderwayCell.self, forCellWithReuseIdentifier: cell2)
    collectionView?.register(GoalsViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
    
    
    fetchGoals()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell1, for: indexPath) as! GoalsViewCell
      cell.goals = goals[indexPath.item]
      if indexPath.row == 0 {
        cell.goalImageView.image = UIImage(named: "bike")
      } else if indexPath.row == 1 {
        cell.goalImageView.image = UIImage(named: "gymaholic")
      } else if indexPath.row == 2 {
        cell.goalImageView.image = UIImage(named: "calorie")
      }
       return cell

  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return goals.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
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
    
    let goalPicked = goals[indexPath.item]
    print(goalPicked.goalName, goalPicked.goalDescription)
    
    let goalDetailVC = GoalDetailViewController()
    goalDetailVC.goal = goalPicked
    navigationController?.pushViewController(goalDetailVC, animated: true)
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
        
        guard let goalDictionary = value as? [String: Any] else { return }
        let goals = Goals(userUid: uid, dictionary: goalDictionary)
        self.goals.append(goals)
        print("DAVIDPOO: \(goals)")
      })
      
      self.collectionView?.reloadData()
      
      }
    }
  
  

  
  }

