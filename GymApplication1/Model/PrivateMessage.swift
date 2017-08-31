//
//  PrivateMessage.swift
//  GymApplication1
//
//  Created by David on 30/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class PrivateMessage: NSObject {
  
  var fromUID: String
  var text: String
  var messageDate: NSNumber?
  var userUID: String
  
  init(dictionary: [String: Any]) {
    self.messageDate = dictionary["messageDate"] as? NSNumber
    self.fromUID = dictionary["fromUID"] as? String ?? ""
    self.text = dictionary["text"] as? String ?? ""
    self.userUID = dictionary["userUID"] as? String ?? ""
  }
  
  func chatPartnerID() -> String {
    
    if fromUID == Auth.auth().currentUser?.uid {
      return userUID
    } else {
      return fromUID 
    }
  }
  
}
