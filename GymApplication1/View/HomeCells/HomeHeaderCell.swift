//
//  HomeHeaderCell.swift
//  GymApplication1
//
//  Created by David on 10/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class HomeHeaderCell: UICollectionViewCell {
  
  var user: User? {
    didSet {
      setupProfileImage()
      
      guard let user = self.user?.username else { return }
      greetingText.text = "Welcome \(user), how are you today?"
    }
  }
  
  let dividerView: UIView = {
    let v = UIView()
    v.backgroundColor = .lightGray
    return v
  }()
  
  let greetingText: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Avenir", size: 18)
    return label
  }()
  
  let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.layer.borderWidth = 1
    iv.layer.borderColor = UIColor.black.cgColor
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
 
    
    addSubview(profileImageView)
    addSubview(greetingText)
    addSubview(dividerView)
    
    profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
    profileImageView.layer.cornerRadius = 70 / 2
    profileImageView.clipsToBounds = true
    
    greetingText.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 250, height: 100)
    
    dividerView.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 49, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    
    setupProfileImage()
    
  }
  
  fileprivate func setupProfileImage() {
    guard let ptofileImageUrl = user?.profileImageUrl else { return }
    
    guard let url = URL(string: ptofileImageUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for the error and then construct the image using the data
      if let err = err {
        print("Failed to fetch profile image:", err)
        return
      }
      
      guard let data = data else { return }
      
      let image = UIImage(data: data)
      
      DispatchQueue.main.async {
        self.profileImageView.image = image
      }
      
      }.resume()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
