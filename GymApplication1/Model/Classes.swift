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
  let classAvailability: String
  let classDate: String
  
  init(className: String, dictionary: [String: Any]) {
    self.className = className
    self.classDescription = dictionary["classDescription"] as? String ?? ""
    self.classTime = dictionary["classTime"] as? String ?? ""
    self.classDuration = dictionary["classDuration"] as? String ?? ""
    self.classLocation = dictionary["classLocation"] as? String ?? ""
    self.classAvailability = dictionary["classAvailability"] as? String ?? ""
    self.classDate = dictionary["classDate"] as? String ?? ""
  }
}
