//
//  File.swift
//  GymApplication1
//
//  Created by David on 16/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct User {
  let username: String
  let profileImageUrl: String
  
  init(dictionary: [String: Any]) {
    self.username = dictionary["username"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
  }
  
  
  
}
