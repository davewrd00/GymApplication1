//
//  SettingsLauncher.swift
//  GymApplication1
//
//  Created by David on 13/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class Setting: NSObject {
  
  let name: SettingName
  let imageName: String
  
  init(name: SettingName, imageName: String) {
    self.name = name
    self.imageName = imageName
  }
}

enum SettingName: String {
  
  case Cancel = "Cancel"
  case Profile = "Profile"
  case SignOut = "Log out"
  case SendFeedback = "Send feedback"
  case Help = "Help"
}

class SettingsLaucnher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  let blackView = UIView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    return cv
  }()
  
  let cellId = "cellId"
  
  let cellHeight: CGFloat = 50
  
  let settings: [Setting] = {
    let profileSetting = Setting(name: .Profile, imageName: "profile")
    let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
    let signOutSetting = Setting(name: .SignOut, imageName: "logout")
    let sendFeedbackSetting = Setting(name: .SendFeedback, imageName: "feedback")
    let helpSetting = Setting(name: .Help, imageName: "help")
    return [profileSetting, sendFeedbackSetting, helpSetting, cancelSetting, signOutSetting]
  }()
  
  var homeController: HomeViewController1?
  
  @objc func showSettings() {
    if let window = UIApplication.shared.keyWindow {
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height: CGFloat = CGFloat(settings.count) * cellHeight
      let y = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.blackView.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }, completion: nil)
      
    }
    
  }
  
  @objc func handleDismiss(setting: Setting) {
    print("howdy")
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.blackView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow {
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
    }) { (_) in
      if setting.name != .Cancel {
        if setting.name == .SignOut {
          self.homeController?.handleLogOut()
        } else {
          self.homeController?.showSettingsController(setting: setting)
        }
      }
    }
  }
  
  @available(iOS 6.0, *)
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  
  @available(iOS 6.0, *)
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
    
    let setting = settings[indexPath.item]
    cell.setting = setting
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let setting = self.settings[indexPath.item]
    handleDismiss(setting: setting)
  }
  
  override init() {
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
  }

}
