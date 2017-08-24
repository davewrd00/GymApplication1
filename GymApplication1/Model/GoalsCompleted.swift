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
  
  init(goalUID: Int, dictionary: [String: Any]) {
    self.goalUID = goalUID
    self.goalName = dictionary["goalName"] as? String ?? ""
  }
  
}
