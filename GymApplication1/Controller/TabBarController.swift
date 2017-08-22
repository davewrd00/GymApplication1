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
      let homeVC = HomeViewController1()
      let homeNavController = UINavigationController(rootViewController: homeVC)
      homeNavController.tabBarItem.image = #imageLiteral(resourceName: "home")
      
      //class controller
      let classLayout = UICollectionViewFlowLayout()
      let classController = ClassViewController(collectionViewLayout: classLayout)
      let classNavController = UINavigationController(rootViewController: classController)
      classNavController.tabBarItem.image = #imageLiteral(resourceName: "classes")
    
      // community controller
    let socialLayout = UICollectionViewFlowLayout()
    let socialVC = SocialCommunityViewController(collectionViewLayout: socialLayout)
    let socialNavController = UINavigationController(rootViewController: socialVC)
    socialNavController.tabBarItem.image = #imageLiteral(resourceName: "community")
      
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
      tabBar.barTintColor = UIColor.rgb(red: 80, green: 81, blue: 79)
      
      
      viewControllers = [homeNavController, classNavController, socialNavController, achievementsNavController, goalsNavController]
      
      //Modifying tab bar item insets
      guard let items = self.tabBar.items else { return }
      
      for item in items {
        item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        item.title = ""
      }
    }
  
  
}
