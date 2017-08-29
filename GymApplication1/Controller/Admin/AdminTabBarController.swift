//
//  AdminTabBarController.swift
//  GymApplication1
//
//  Created by David on 17/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit

class AdminTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTabBar()
  }
  
  func setupTabBar() {
    
    // Add class Controller
    let adminVC = AdminViewController()
    let adminNavController = UINavigationController(rootViewController: adminVC)
    adminNavController.tabBarItem.image = #imageLiteral(resourceName: "classes")
    
    //Add a new goal VC
    let addGoalVC = AddGoalViewController()
    let addGoalNavController = UINavigationController(rootViewController: addGoalVC)
    addGoalNavController.tabBarItem.image = #imageLiteral(resourceName: "goals")
    
    tabBar.tintColor = .white
    tabBar.barTintColor = UIColor.rgb(red: 80, green: 81, blue: 79)
    
    viewControllers = [adminNavController, addGoalNavController]
    
    guard let items = self.tabBar.items else { return }
    
    for item in items {
      item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
      item.title = ""
    }
    
  }
  
}
