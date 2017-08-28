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
  
  static let ds = DataService()
  static let UID = Auth.auth().currentUser?.uid 
  
 static let sharedInstance = DataService()
  
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

  
}


