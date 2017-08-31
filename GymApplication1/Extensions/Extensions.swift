//
//  Extensions.swift
//  GymApplication1
//
//  Created by David on 09/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit


extension UIColor {
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  static func mainBlue() -> UIColor {
    return UIColor.rgb(red: 17, green: 154, blue: 237)
  }
  
}


extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if width != 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
}

extension UIView{
  func addConstraintsWithFormat(format:String, views:UIView...){
    var viewsDictionary = [String:UIView]()
    
    for(index, view) in views.enumerated(){
      let key:String = "v\(index)"
      
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
      
      
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    
  }
}

extension UIAlertController {
  func addCustomAlert(title: String, message: String, actionTitle: String, completion: @escaping () -> ()) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: actionTitle, style: .cancel) { (action) in
      completion()
    }
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
}

extension UIImageView {
  func setupProfileImage(user: User, completionBlock: @escaping (UIImage) -> ()) {
    let ptofileImageUrl = user.profileImageUrl
    
    guard let url = URL(string: ptofileImageUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // check for the error and then construct the image using the data
      if let err = err {
        print("Failed to fetch profile image:", err)
        return
      }
      
      guard let data = data else { return }
      
      guard let image = UIImage(data: data) else { return }
      
      DispatchQueue.main.async {
        completionBlock(image)
        //self.profileImageView.image = image
      }
      
      }.resume()
  }
}





