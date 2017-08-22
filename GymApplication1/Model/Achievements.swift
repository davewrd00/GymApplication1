//
//  GoalsCurrentlyUnderway.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct Achievements {
  
  let userUid: String
  let achievementName: String
  let achievementEarned: Bool
  let achievementDescription: Bool
  
  init(useruID: String, achName: String, achEarned: Bool, achDescription: Bool) {
    self.userUid = useruID
    self.achievementName = achName
    self.achievementEarned = achEarned
    self.achievementDescription = achDescription
  }
  
  
}
