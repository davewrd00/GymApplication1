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
  
  init(className: String, dictionary: [String: Any]) {
    self.className = className
    self.classDescription = dictionary["classDescription"] as? String ?? ""
  }
}
