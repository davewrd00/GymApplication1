//
//  DataService.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper


class DataService {
  
  let adminUID = "vAOe4JijoDYO8jTD7TCwceo4qcs2"
  
  static let ds = DataService()
  static let UID = Auth.auth().currentUser?.uid 
  
 static let sharedInstance = DataService()
  
  // MARK: Users fetching
  
  func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
    print("Fetching user with uid", uid)
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let userDictionary = snapshot.value as? [String: Any] else { return }
      
      let user = User(uid: uid, dictionary: userDictionary)
      print(user.username)
      
      completion(user)
      
    }) { (err) in
      print("Failed to fetch user for posts", err)
    }
  }
  
  func fetchAllUsersFromDatabase(completionBlock: @escaping (User) -> ()) {
    let ref = Database.database().reference().child("users")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        if key == Auth.auth().currentUser?.uid {
          return
        }
        if key == self.adminUID {
          return
        }
        guard let userDict = value as? [String: Any] else { return }
        let user = User(uid: key, dictionary: userDict)
        completionBlock(user)
      })
    }) { (err) in
      print("Failed to fetch all users from firebase database")
      return
    }
  }
  
  
  // MARK: Classes
  
  func fetchAllClassesFromDatabase(completionBlock: @escaping (Classes) -> ()) {
    let ref = Database.database().reference().child("classes")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      dictionary.forEach({ (arg) in
        let (key, value) = arg
        let classUID = key
        guard let classDict = value as? [String: Any] else { return }
        let classes = Classes(classUID: classUID, className: key, dictionary: classDict)
        completionBlock(classes)
      })
    }) { (err) in
      print("Failed to fetch all the classes")
      return
    }
  }
  
  func fetchClassesWithUserUID(uid: String, completionBlock: @escaping (String) -> ()) {
    Database.database().reference().child("classesUsersAttending").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      if snapshot.exists() {
        guard let classDict = snapshot.value as? [String: Any] else { return }
        classDict.forEach({ (arg) in
          let (key, _) = arg
          completionBlock(key)
        })
      } else {
        let homeVC = HomeViewController1()
        homeVC.displayNewMessageToUserRegClass()
        return
      }
    }) { (err) in
      print("Failed to fetch list of classes user is attending")
      return
    }
  }
  
  
  // MARK: Updating values
  
  func updateValues(name: String?, uid: String, newValue: Int, completionBlock: @escaping (() -> Void)) {
    guard let name = name else { return }
    let ref = Database.database().reference().child("classes").child(name).child(uid).child("classAvailability")
    
    ref.runTransactionBlock({ (result) -> TransactionResult in
      if let initialValue = result.value as? Int {
        result.value = initialValue + newValue
        return TransactionResult.success(withValue: result)
      } else {
        return TransactionResult.success(withValue: result)
      }
    }) { (err, completion, snapshot) in
      print(err?.localizedDescription ?? "")
      print(completion)
      print(snapshot ?? "")
      if !completion {
        print("Unable to update the availability node")
      } else {
        completionBlock()
      }
    }
  }
  
  func updatePoints(path: String, uid: String, newValue: Int, completionBlock: @escaping (Int) -> ()) {
    let ref = Database.database().reference().child(path).child(uid).child("pointsEarned")
    
    ref.runTransactionBlock({ (result) -> TransactionResult in
      if let initialValue = result.value as? Int {
        result.value = initialValue + newValue
        //guard let resultToPass = result.value as? Int else { return }
        completionBlock(initialValue + newValue)
        return TransactionResult.success(withValue: result)
      } else {
        return TransactionResult.success(withValue: result)
      }
    }) { (err, completion, snapshot) in
      print(err?.localizedDescription ?? "")
      print(completion)
      print(snapshot ?? "")
      if !completion {
        print("Unable to update the availability node")
      } else {
        print("Happy days")
      }
    }
  }
  
  // MARK: Social
  
  func fetchPostsFromDatabase(user: User, completionBlock: @escaping (Post) -> ()) {
    let ref = Database.database().reference().child("posts").child(user.uid)
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      guard let dictionaries = snapshot.value as? [String: Any] else { return }
      dictionaries.forEach({ (arg) in
        let (key, value) = arg
        guard let dictionary = value as? [String: Any] else { return }
        
        var post = Post(user: user, dictionary: dictionary)
        post.id = key
        completionBlock(post)
      })
    }) { (err) in
      print("Failed to fetch the posts...", err)
      return
    }
  }
  
  func saveImageToFirebaseStorage(uploadData: Data, imageLocation: String, completionBlock: @escaping ((String) -> Void )) {
    let fileName = NSUUID().uuidString
    Storage.storage().reference().child(imageLocation).child(fileName).putData(uploadData, metadata: nil) { (metadata, err) in
      if let err = err {
        print("Failed yo uplaod the image to firebase storage")
        return
      }
      guard let profileImageURL = metadata?.downloadURL()?.absoluteString else { return }
      completionBlock(profileImageURL)
      
      print("Successfully been able to upload image to storage in FB")
    }
  }
  
  
  // MARK: Achievements
  
  func fetchAchievementsFromFirebase(completionBlock: @escaping (Achievements) -> ()) {
    Database.database().reference().child("achievements").observeSingleEvent(of: .value, with: { (snapshot) in
      guard let achievementDict = snapshot.value as? [String: Any] else { return }
      achievementDict.forEach({ (arg) in
        let (key, value) = arg
        guard let dict = value as? [String: Any] else { return }
        let achievement = Achievements(achName: key, dictionary: dict)
        completionBlock(achievement)
      })
    }) { (err) in
      print("Errror fetching all the achievements")
    }
  }
  
  func fetchAchievementsEarnedByUser(uid: String, completionBlock: @escaping (String) -> ()) {
    Database.database().reference().child("achievementsEarnedByUser").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let achievementDict = snapshot.value as? [String: Any] else { return }
      achievementDict.forEach({ (arg) in
        let (key, _) = arg
        completionBlock(key)
      })
    }) { (err) in
      print("Failed to fetch the complete achievements")
      return
    }
  }
  
  
  // MARK: Goals
  
  func fetchCompoletedGoals(uid: String, completionBlock: @escaping (GoalsCompleted, Int) -> ()) {
    Database.database().reference().child("goalsCompleteByUser").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let dict = snapshot.value as? [String: Any] else { return }
      dict.forEach({ (arg) in
        let (key, value) = arg
        guard let intKey = Int(key) else { return }
        print("HA \(key, value)")
        guard let goalCompleteDict = value as? [String: Any] else { return }
        let goalComplete = GoalsCompleted(goalUID: intKey, dictionary: goalCompleteDict)
        guard let goalUID = goalComplete.goalUID as? Int else { return }
        completionBlock(goalComplete, goalUID)
      })
    }) { (err) in
      print("Unable to download completed goals")
    }
  }


}





