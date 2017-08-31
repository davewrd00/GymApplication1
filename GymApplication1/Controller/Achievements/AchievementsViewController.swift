//
//  AchievementsViewController.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class AchievementsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  
  var hasAchieved: Bool = false
  
  var pointsEarned: Int?
  
  var achievementsEarnedNames = [String]() {
    didSet {
      for name in achievementsEarnedNames {
        print("BOOOB \(name)")

      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchCompletedAchievements()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue).rawValue): UIColor.white, NSAttributedStringKey(rawValue: NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue).rawValue): UIFont(name: "Avenir", size: 20) ?? ""]
    navigationController?.navigationBar.isTranslucent = false
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(AchievementsCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView?.delegate = self
    collectionView?.dataSource = self
    
    tabBarItem.title = "Achievements"
    
    fetchCompletedAchievements()
  }
  
  fileprivate func fetchCompletedAchievements() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    DataService.sharedInstance.fetchAchievementsEarnedByUser(uid: uid) { (key) in
      self.achievementsEarnedNames.append(key)
      self.collectionView?.reloadData()
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! AchievementsCell
    cell.cellView.alpha = 0.2
    cell.isUserInteractionEnabled = false
    if indexPath.row == 0 {
      
      cell.imageView.image = UIImage(named: "bronze_medal")
      cell.achievementNameLabel.text = "Bronze medal"
      cell.achievementDescription.text = "Earn 1000 points to earn this medal to win some gym goodies!!"
      if self.achievementsEarnedNames.contains("bronze") {
        cell.isUserInteractionEnabled = true
        cell.cellView.alpha = 1
      }
    
    } else if indexPath.row == 1 {
      
      cell.imageView.image = UIImage(named: "silver_medal")
      cell.achievementNameLabel.text = "Silver medal"
      cell.achievementDescription.text = "Earn 2500 points to earn this medal to win a free gym shirt!"
      if self.achievementsEarnedNames.contains("silver") {
        cell.cellView.alpha = 1
        cell.isUserInteractionEnabled = true
      }
      
    } else if indexPath.row == 2 {
      if self.achievementsEarnedNames.contains("gold") {
    
        cell.isUserInteractionEnabled = true
        cell.cellView.alpha = 1
      }
      cell.imageView.image = UIImage(named: "gold_medal")
      cell.achievementNameLabel.text = "Gold medal"
      cell.achievementDescription.text = "Earn 5000 points and become a pro and enjoy a whole months membership on us - FREE!!"
      
    } else if indexPath.row == 3 {
      cell.imageView.image = UIImage(named: "athlete_medal")
      cell.achievementNameLabel.text = "Veteran medal"
      cell.achievementDescription.text = "Become a veteran and earn 10000 points to win £100!"
    } else if indexPath.row == 4 {
      cell.imageView.image = UIImage(named: "outstanding_medal")
      cell.achievementNameLabel.text = "Professional"
      cell.achievementDescription.text = "Earn 12,500 points and recieve one months membership for you and a buddy - FREE!!"
    } else {
      cell.imageView.image = UIImage(named: "olympian")
      cell.achievementNameLabel.text = "Olympian"
      cell.achievementDescription.text = "Earn 15,000 points to win a whole years membership!"
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //print(indexPath.item)
    
    hasAchievedMedal(medalChosen: indexPath)
    
  }
  
  func hasAchievedMedal(medalChosen: IndexPath) {
    print(medalChosen.item)
  }

}