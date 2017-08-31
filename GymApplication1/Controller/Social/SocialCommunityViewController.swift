//
//  SocialCommunityViewController.swift
//  GymApplication1
//
//  Created by David on 22/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase

class SocialCommunityViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SocialFeedCellDelegate {
  
  var posts = [Post]()
  
  override func viewWillAppear(_ animated: Bool) {
    tabBarController?.tabBar.isHidden = false
//    fetchAllPosts()
//    fetchFollowingUserIds()
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
    fetchFollowingUserIds()
    // Need to fetch posts from only those you are firneds for? Perhaps not in this iteration - Look at Instgram clone application!!!!
  
  }
  
  fileprivate func fetchFollowingUserIds() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("friends").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
      userIdsDictionary.forEach({ (arg) in
        let (key, value) = arg
        
        DataService.sharedInstance.fetchUserWithUID(uid: key, completion: { (user) in
          self.fetchPostsWithUser(user: user)
        })
        
      })
    }) { (err) in
      print("Failed to fetch the following users ids:" , err)
    }
  }
  
  fileprivate func fetchPosts() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    DataService.sharedInstance.fetchUserWithUID(uid: uid) { (user) in
      self.fetchPostsWithUser(user: user)
    }
    
  }
  
  fileprivate func fetchPostsWithUser(user: User) {
    
    DataService.sharedInstance.fetchPostsFromDatabase(user: user) { (post) in
      self.posts.append(post)
      self.posts.sort(by: { (p1, p2) -> Bool in
        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
      })
      self.collectionView?.reloadData()
    }
  }
  
  fileprivate func  setupNavBar() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "write").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleWriteToFeed))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearchForFriends))
  }
  
  @objc func handleRefresh() {
    print("Handling refresh yall")
  
  }
  func didTapComment(post: Post) {
    print("This message is coming from")
    print(post.caption)
    
    let commentController = FeedCommentController(collectionViewLayout: UICollectionViewFlowLayout())
    commentController.post = post
    navigationController?.pushViewController(commentController, animated: true)
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
    cell.delegate = self

    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 450)
  }
  
  
}