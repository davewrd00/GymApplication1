//
//  AcceptClassViewController.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class AcceptClassViewController: UIViewController {
  
  var classes: Classes? {
    didSet {
      print(classes?.className ?? "")
      classLabel.text = classes?.className
    }
  }
  
  let acceptButton: UIButton = {
    let b = UIButton(type: .custom)
    b.backgroundColor = .green
    b.alpha = 0.6
    b.layer.cornerRadius = 5
    b.clipsToBounds = true
    b.contentMode = .scaleAspectFill
    let image = UIImage(named: "tick")
    b.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    b.addTarget(self, action: #selector(handleSignUpToClass), for: .touchUpInside)
    return b
  }()
  
  let declineButton: UIButton = {
    let b = UIButton(type: .custom)
    b.backgroundColor = .red
    b.alpha = 0.6
    let image = UIImage(named: "exit")
    b.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    b.layer.cornerRadius = 5
    b.clipsToBounds = true
    b.contentMode = .scaleAspectFill
    b.addTarget(self, action: #selector(handleDecline), for: .touchUpInside)
    return b
  }()
  
  lazy var infoView: UIView = {
    let v = UIView()
    //v.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
    v.layer.cornerRadius = 5
    v.backgroundColor = .purple
    
    
    let nameLbl = UILabel()
    nameLbl.text = self.classes?.className
    nameLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 36.0)
    nameLbl.textColor = .white
    nameLbl.textAlignment = .left
    nameLbl.translatesAutoresizingMaskIntoConstraints = false
    v.addSubview(nameLbl)
    nameLbl.anchor(top: v.topAnchor, left: v.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 0)
    
//    let dateLbl = UILabel()
//    nameLbl.text = self.classes?.classDate
//    dateLbl.textAlignment = .left
//    dateLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
//    dateLbl.textColor = .white
//    dateLbl.translatesAutoresizingMaskIntoConstraints = false
//    v.addSubview(dateLbl)
//    dateLbl.anchor(top: nameLbl.bottomAnchor, left: v.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 0)
//
    return v
  }()
  
  lazy var classLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 32.0)
    return lbl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    view.addSubview(acceptButton)
    view.addSubview(declineButton)
    view.addSubview(infoView)
    
    acceptButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 120, height: 40)
    
    declineButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 120, height: 40)
    
    
    infoView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 200)
    infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  @objc func handleDecline() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handleSignUpToClass() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let classToAttend: Dictionary<String, Any>
    classToAttend = ["className": self.classes?.className ?? "",
                     "classDate": self.classes?.classDate ?? ""]
    
    Database.database().reference().child("users").child(uid).child("classesAttending").childByAutoId().setValue(classToAttend) { (err, _) in
      if let _ = err {
        print("Unable to upload class to user in DB")
        return
      }
      print("Successfully been able to add this to user in FB")
      self.dismiss(animated: true, completion: nil)
    }
  }
  
}
