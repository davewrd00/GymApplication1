//
//  SocialCommunityViewController.swift
//  GymApplication1
//
//  Created by David on 22/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class SocialCommunityViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var posts = [Post]()
  
  override func viewWillAppear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = false
    fetchAllPosts()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    
    navigationController?.hidesBarsOnSwipe = true
    navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    navigationController?.navigationBar.isTranslucent = false
    
    collectionView?.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    collectionView?.register(SocialFeedCell.self, forCellWithReuseIdentifier: "cellId")
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    collectionView?.refreshControl = refreshControl
    fetchAllPosts()
    
  }
  
  fileprivate func fetchAllPosts() {
    fetchPosts()
    // Need to fetch posts from only those you are firneds for? Perhaps not in this iteration - Look at Instgram clone application!!!!
  
  }
  
  fileprivate func fetchPosts() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.fetchUserWithUID(uid: uid) { (user) in
      self.fetchPostsWithUser(user: user)
    }
    
  }
  
  fileprivate func fetchPostsWithUser(user: User) {
    let ref = Database.database().reference().child("posts").child(user.uid)
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      
      if !snapshot.exists() {
        print("No user posts")
        // Do an animation explaining to the user they need to post to view their posts
        
        self.showAlertToUserRegardingPost()
        
        return
      }
      
      self.collectionView?.refreshControl?.endRefreshing()
      
      guard let dictionaries = snapshot.value as? [String: Any] else { return }
      
      dictionaries.forEach({ (arg) in
        let (key, value) = arg
        
        guard let dictionary = value as? [String: Any] else { return }
        
        var post = Post(user: user, dictionary: dictionary)
        post.id = key
        
        self.posts.append(post)
        self.posts.sort(by: { (p1, p2) -> Bool in
          return p1.creationDate.compare(p2.creationDate) == .orderedDescending
        })
        self.collectionView?.reloadData()
        
      })
      
    }) { (err) in
      print("Failed to fetch posts:", err)
      return
    }
    
  }
  
  fileprivate func showAlertToUserRegardingPost() {
    print("Handling this action regareding telling the user that their is no posts to show!")
    
    let alertController = UIAlertController(title: "Ooops", message: "No posts yet by you nor your friends", preferredStyle: .alert)
    let okayAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    alertController.addAction(okayAction)
    self.present(alertController, animated: true, completion: nil)
    
  }
  
  fileprivate func  setupNavBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "write").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleWriteToFeed))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearchForFriends))
  }
  
  @objc func handleRefresh() {
    print("Handling refresh yall")
  }
  
  @objc func handleWriteToFeed() {
    print(123)
    let shareFeedVC = ShareFeedViewController()
    navigationController?.pushViewController(shareFeedVC, animated: true)
    
  }
  
  @objc func handleSearchForFriends() {
    let searchLayout = UICollectionViewFlowLayout()
    let userSearchController = UserSearchController(collectionViewLayout: searchLayout)
    navigationController?.pushViewController(userSearchController, animated: true)
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SocialFeedCell
    cell.backgroundColor = .white
    
    cell.post = posts[indexPath.item]
    //cell.delegate = self

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 450)
  }
  
  
}
