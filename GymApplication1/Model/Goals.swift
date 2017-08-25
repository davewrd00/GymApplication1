//
//  Goals.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct Goals {
  let goalName: String
  let goalDescription: String
  let goalPoints: Int
  let userUid: String
  let goalImageUrl: String
  var goalCompleted: Bool
  let goalUID: Int
  
  init(userUid: String, dictionary: [String: Any]) {
    self.goalName = dictionary["goalName"] as? String ?? ""
    self.goalDescription = dictionary["goalDescription"] as? String ?? ""
    self.goalPoints = dictionary["goalPoints"] as? Int ?? 0
    self.goalImageUrl = dictionary["goalImageUrl"] as? String ?? ""
    self.goalUID = dictionary["goalUID"] as? Int ?? 0
    self.userUid = userUid
    self.goalCompleted = false
  }
  
  
}
