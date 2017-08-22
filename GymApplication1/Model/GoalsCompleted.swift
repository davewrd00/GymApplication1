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
  let goalsPoints: Int
  let goalAchieved: Bool
  
  init(goalName: String, goalPoints: Int, goalAchieved: Bool) {
    self.goalName = goalName
    self.goalsPoints = goalPoints
    self.goalAchieved = goalAchieved
  }
  
}
