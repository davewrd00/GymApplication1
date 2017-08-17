//
//  GoalDetailViewController.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import SCLAlertView

class GoalDetailViewController: UIViewController {
  
  var goal: Goals? {
    didSet {
      if goal?.goalName == "Watt bike?" {
        imageViewOfGoal.image = UIImage(named: "bike")
      } else if goal?.goalName == "Gym-A-Holic" {
        imageViewOfGoal.image = UIImage(named: "gymaholic")
      } else {
        imageViewOfGoal.image = UIImage(named: "calorie")
      }
      goalNameLabel.text = goal?.goalName
      goalDescriptionLabel.text = goal?.goalDescription
    }
    
  }
  
  let exitButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.text = "X"
    button.backgroundColor = .red
    button.layer.cornerRadius = 5
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSize(width: 1, height: 1)
    button.layer.shadowRadius = 1
    let image = UIImage(named: "back_btn")
    button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleExitFromClassVC), for: .touchUpInside)
    button.alpha = 0.6
    return button
  }()
  
  let acceptButton: UIButton = {
    let b = UIButton(type: .custom)
    b.backgroundColor = .green
    b.alpha = 0.6
    b.layer.cornerRadius = 5
    b.clipsToBounds = true
    b.contentMode = .scaleAspectFill
    let image = UIImage(named: "tick")
    b.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    b.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
    return b
  }()
  
  let imageViewOfGoal: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    return iv
  }()
  
  let goalNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
    lbl.textColor = .black
    return lbl
  }()
  
  let goalDescriptionBox: UIView = {
    let v = UIView()
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOffset = CGSize(width: 8, height: 12)
    v.layer.shadowOpacity = 0.4
    v.backgroundColor = .white
    v.layer.shadowRadius = 5.0
    v.layer.cornerRadius = 5
    return v
  }()
  
  let goalDescriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    return lbl
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.isHidden = true
    self.tabBarController?.tabBar.isHidden = true
    
    view.addSubview(exitButton)
    view.addSubview(imageViewOfGoal)
    view.addSubview(goalNameLabel)
    view.addSubview(acceptButton)
    view.addSubview(goalDescriptionBox)
    view.addSubview(goalDescriptionLabel)
    
    imageViewOfGoal.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 300)
    
    goalDescriptionBox.anchor(top: imageViewOfGoal.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 300, height: 100)
    
    goalDescriptionLabel.anchor(top: goalDescriptionBox.topAnchor, left: goalDescriptionBox.leftAnchor, bottom: goalDescriptionBox.bottomAnchor, right: goalDescriptionBox.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    
    exitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 50, height: 50)
    goalNameLabel.anchor(top: imageViewOfGoal.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    goalNameLabel.centerYAnchor.constraint(equalTo: imageViewOfGoal.centerYAnchor).isActive = true
    goalNameLabel.centerXAnchor.constraint(equalTo: imageViewOfGoal.centerXAnchor).isActive = true
    
    acceptButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 50, height: 50)
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
  }
  
  @objc func handleExitFromClassVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func handleAddGoal() {
    guard let goalName = goal?.goalName else { return }
    
    let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
    
    let alertView = SCLAlertView(appearance: appearance)
    alertView.showSuccess("Started \(goalName)!", subTitle: "Good luck!", duration: 1.5)
    
    // Need to now make a call to FB so that this goal that has been added to added to the correct user. Then, in the HomeVC I need to call for totalPoints earned and update that aswell as the level!
  }
}
