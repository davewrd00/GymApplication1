//
//  File.swift
//  GymApplication1
//
//  Created by David on 27/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct AchievementsEarned {
  
  let achievementName: String
  let hasAchieved: Bool
  
  init(achName: String, hasAchieved: Bool) {
    self.achievementName = achName
    self.hasAchieved = hasAchieved
  }
  
  var achName: String {
    return achievementName
  }
}
