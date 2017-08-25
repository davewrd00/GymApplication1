//
//  GoalUnderway.swift
//  GymApplication1
//
//  Created by David on 18/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct GoalsCompleted {
  
  let goalName: String
  let goalUID: Int
  
  let goalDescription: String
  let goalPoints: Int
  let goalImageUrl: String
  
  
  init(goalUID: Int, dictionary: [String: Any]) {
    self.goalUID = goalUID
    self.goalName = dictionary["goalName"] as? String ?? ""
    self.goalDescription = dictionary["goalDescription"] as? String ?? ""
    self.goalPoints = dictionary["goalPoints"] as? Int ?? 0
    self.goalImageUrl = dictionary["goalImageUrl"] as? String ?? ""
  }
  
}
