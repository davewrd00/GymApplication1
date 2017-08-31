//
//  Classes.swift
//  GymApplication1
//
//  Created by David on 14/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation
import UIKit

struct Classes {
  let className: String
  let classDescription: String
  let classTime: String
  let classDuration: String
  let classLocation: String
  let classAvailability: Int
  let classDate: String
  let classTimeStamp: String
  let classUID: String
  let classLevel: String
  
  
  init(classUID: String, className: String, dictionary: [String: Any]) {
    self.className = className
    self.classDescription = dictionary["classDescription"] as? String ?? ""
    self.classTime = dictionary["classTime"] as? String ?? ""
    self.classDuration = dictionary["classDuration"] as? String ?? ""
    self.classLocation = dictionary["classLocation"] as? String ?? ""
    self.classAvailability = dictionary["classAvailability"] as? Int ?? 0
    self.classDate = dictionary["classDate"] as? String ?? ""
    self.classTimeStamp = dictionary["classTimeStamp"] as? String ?? ""
    self.classLevel = dictionary["classLevel"] as? String ?? ""
    self.classUID = classUID
    

  }
}
