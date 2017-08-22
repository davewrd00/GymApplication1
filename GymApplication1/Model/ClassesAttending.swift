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
  
  init(classUID: String, dictionary: [String: Any]) {
    self.classUID = classUID
    self.classDate = dictionary["classDate"] as? String ?? ""
    self.classDescription = dictionary["classDescription"] as? String ?? ""
    self.className = dictionary["classNamme"] as? String ?? ""
  }
  
  
}
