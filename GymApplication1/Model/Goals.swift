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
  let goalPoints: String
  let userUid: String
  
//  init(goalName: String, goalDescription: String, goalImage: CustomImageView, goalUnderway: Bool, goalAchieved: Bool, goalPoints: String) {
//    self.goalName = goalName
//    self.goalDescription = goalDescription
//    self.goalImage = goalImage
//    self.goalUnderway = goalUnderway
//    self.goalAchieved = goalAchieved
//    self.goalPoints = goalPoints
//  }
  
  init(userUid: String, dictionary: [String: Any]) {
    self.goalName = dictionary["goalName"] as? String ?? ""
    self.goalDescription = dictionary["goalDescription"] as? String ?? ""
    self.goalPoints = dictionary["goalPoints"] as? String ?? ""
    self.userUid = userUid
  }
  
  
}
