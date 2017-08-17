//
//  DataService.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
  
  static let ds = DataService()
  static let UID = Auth.auth().currentUser?.uid 
  
  private var _REF_BASE = DB_BASE
  private var _REF_USERS = DB_BASE.child("users")
  private var _REF_CLASSES = DB_BASE.child("classes")
  
  var REF_BASE: DatabaseReference {
    return _REF_BASE
  }
  
  var REF_USERS: DatabaseReference {
    return _REF_USERS
  }
  
  var REF_CLASSES: DatabaseReference {
    return _REF_CLASSES
  }
  
  func createClass(className: NSString, classData: Dictionary<String, Any>) {
    let key = REF_CLASSES.childByAutoId().key
    let classDetails = classData
    let className = className
    let childUpdates = ["/classes/\(className)\(key)": classDetails]
    DB_BASE.updateChildValues(childUpdates)
  }
    
  
  
}
