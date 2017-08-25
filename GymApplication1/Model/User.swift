//
//  File.swift
//  GymApplication1
//
//  Created by David on 16/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation


struct User {
  let uid: String
  let username: String
  let profileImageUrl: String
  var userPointsEarned: Int
  
  init(uid: String, dictionary: [String: Any]) {
    self.uid = uid
    self.username = dictionary["username"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
    self.userPointsEarned = dictionary["pointsEarned"] as? Int ?? 0
  }
  
  
  
}
