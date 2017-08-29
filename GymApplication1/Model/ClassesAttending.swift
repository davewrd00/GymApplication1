//
//  ClassesAttending.swift
//  GymApplication1
//
//  Created by David on 22/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct ClassesAttending {
  
  let classUID: String
  let classDate: String
  let classDescription: String
  let className: String
  let classLocation: String
  
  init(classDate: String, dictionary: [String: Any]) {
    self.classDate = classDate
    self.classUID = dictionary["classUID"] as? String ?? ""
    self.classDescription = dictionary["classDescription"] as? String ?? ""
    self.className = dictionary["className"] as? String ?? ""
    self.classLocation = dictionary["classLocation"] as? String ?? ""
  }
  
  
}
