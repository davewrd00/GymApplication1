//
//  PrivateMessageView.swift
//  GymApplication1
//
//  Created by David on 30/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class PrivateMessageView: UICollectionViewCell {
  
  var fromUser: User? {
    didSet {
      print("Is thius setting")
      guard let userImageUrl = fromUser?.profileImageUrl else { return }
      self.userProfileImageView.loadImage(urlString: userImageUrl)
      print(userImageUrl)
    }
  }
  
  var messageDates = [Date]()
  
  var privateMessages: PrivateMessage? {
    didSet {
      messageview.text = privateMessages?.text
      
      setupUserImage()
      
      if let seconds = privateMessages?.messageDate {
        let timeStampDate = Date(timeIntervalSince1970: TimeInterval(seconds))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        timeLabel.text = dateFormatter.string(from: timeStampDate)

      }
      
    }
  }
  
  fileprivate func setupUserImage() {
    DataService.sharedInstance.fetchUserWithUID(uid: (privateMessages?.fromUID)!) { (user) in
      let userProfileImageurl = user.profileImageUrl
      self.userProfileImageView.loadImage(urlString: userProfileImageurl)
    }
  }
  
  let timeLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "HH:MM:SS"
    lbl.font = UIFont(name: "HelveticaNeue-Light", size: 12)
    lbl.textColor = .lightGray
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  let userProfileImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .yellow
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()
  
  var messageview: UITextView = {
    let mv = UITextView()
    mv.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
    mv.textColor = .white
    mv.translatesAutoresizingMaskIntoConstraints = false
    mv.backgroundColor = .clear
    return mv
  }()
  
  var view: UIView = {
    let v = UIView()
    return v
  }()
  
  let bubbleView: UIView = {
    let v = UIView()
    v.backgroundColor = .red
    v.alpha = 0.6
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  var bubbleWidthAnchor: NSLayoutConstraint?
  var bubbleViewRightAnchor: NSLayoutConstraint?
  var bubbleViewLeftAnchor: NSLayoutConstraint?
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(bubbleView)
    addSubview(messageview)
    addSubview(userProfileImageView)

    bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
    bubbleViewRightAnchor?.isActive = true
    
    bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    
    bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
    bubbleWidthAnchor?.isActive = true
    
    bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8)
    bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    bubbleView.layer.cornerRadius = 15
    bubbleView.layer.masksToBounds = true
    
    
    messageview.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
    messageview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    messageview.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
    messageview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
    userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    userProfileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    userProfileImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
    userProfileImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    userProfileImageView.layer.cornerRadius = 35 / 2
    userProfileImageView.layer.masksToBounds = true

    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
