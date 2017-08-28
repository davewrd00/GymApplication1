//
//  GoalsCurrentlyUnderway.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

class Achievements: NSObject {
  
  let achievementName: String
  let pointsToEarn: Int
  let achievementDescription: String
  
  init(achName: String, dictionary: [String: Any]) {
    self.achievementName = achName
    self.pointsToEarn = dictionary["pointsToEarn"] as? Int ?? 0
    self.achievementDescription = dictionary["achievementDescription"] as? String ?? ""

  }

}


