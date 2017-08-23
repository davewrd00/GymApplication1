//
//  Post.swift
//  GymApplication1
//
//  Created by David on 23/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import Foundation

struct Post {
  
  var id: String?
  
  let imageUrl: String
  let user: User
  let caption: String
  let creationDate: Date
  
  var hasLiked = false
  
  init(user: User, dictionary: [String: Any]) {
    self.user = user
    self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    self.caption = dictionary["caption"] as? String ?? ""
    
    let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
    self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
  }
}
