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
  let goalImage: CustomImageView
  let goalUnderway: Bool
  let goalAchieved: Bool
  let goalPoints: String
  
  init(goalName: String, goalDescription: String, goalImage: CustomImageView, goalUnderway: Bool, goalAchieved: Bool, goalPoints: String) {
    self.goalName = goalName
    self.goalDescription = goalDescription
    self.goalImage = goalImage
    self.goalUnderway = goalUnderway
    self.goalAchieved = goalAchieved
    self.goalPoints = goalPoints
  }
}
