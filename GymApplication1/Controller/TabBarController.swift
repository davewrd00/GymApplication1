//
//  TabBarController.swift
//  GymApplication1
//
//  Created by David on 10/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
      setupViewControllers()
      
    }
  
  func setupViewControllers() {
    //home controller
    let homeLayout = UICollectionViewFlowLayout()
    let homeVC = HomeViewController(collectionViewLayout: homeLayout)
    let homeNavController = UINavigationController(rootViewController: homeVC)
    homeNavController.tabBarItem.image = #imageLiteral(resourceName: "home")
    
    //class controller
    let classLayout = UICollectionViewFlowLayout()
    let classController = ClassViewController(collectionViewLayout: classLayout)
    let classNavController = UINavigationController(rootViewController: classController)
    classNavController.tabBarItem.image = #imageLiteral(resourceName: "classes")
    
    //Achievements controller
    let achievementsLayout = UICollectionViewFlowLayout()
    let achievementsController = AchievementsViewController(collectionViewLayout: achievementsLayout)
    let achievementsNavController = UINavigationController(rootViewController: achievementsController)
    achievementsNavController.tabBarItem.image = #imageLiteral(resourceName: "achievements")
    
    // Goals controller
    let goalsLayout = UICollectionViewFlowLayout()
    let goalsController = GoalsViewController(collectionViewLayout: goalsLayout)
    let goalsNavController = UINavigationController(rootViewController: goalsController)
    goalsNavController.tabBarItem.image = #imageLiteral(resourceName: "goals")
    
    tabBar.tintColor = .white
    tabBar.barTintColor = .purple
    
    
    viewControllers = [homeNavController, classNavController, achievementsNavController, goalsNavController]
    
    //Modifying tab bar item insets
    guard let items = self.tabBar.items else { return }
    
    for item in items {
      item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
    }
  }
  
}
