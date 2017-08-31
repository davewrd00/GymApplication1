//
//  AcceptClassViewController.swift
//  GymApplication1
//
//  Created by David on 15/08/2017.
//  Copyright © 2017 David Ward. All rights reserved.
//

import UIKit
import Firebase
import EventKit

class AcceptClassViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  
  let cellId = "cellId"
  
  var timeStamp: String?
  
  var classes: Classes? {
    didSet {
      classNameLabel.text = classes?.className
      print("WAAA \(classes)")
      
      guard let classDate = classes?.classDate else { return }
      
      let dateString = classDate
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
      guard let dateFromString = dateFormatter.date(from: dateString) else { return }
      
      let dateFormatter2 = DateFormatter()
      dateFormatter2.dateFormat = "MMM d, yyyy - HH:mm"
      let stringFromDate = dateFormatter2.string(from: dateFromString)
      
      self.classDateAndTimeLbl.text = stringFromDate
      
    }
  }
  
  var classDate = [String]()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    return cv
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
    b.addTarget(self, action: #selector(handleSignUpToClass), for: .touchUpInside)
    return b
  }()
  
  let declineButton: UIButton = {
    let b = UIButton(type: .custom)
    b.backgroundColor = .red
    b.alpha = 0.6
    let image = UIImage(named: "exit")
    b.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    b.clipsToBounds = true
    b.contentMode = .scaleAspectFill
    b.layer.cornerRadius = 5
    b.addTarget(self, action: #selector(handleDecline), for: .touchUpInside)
    return b
  }()
  
  lazy var infoView: UIImageView = {
    let v = UIImageView()
    v.image = UIImage(named: "aqua")
    return v
  }()
  
  let classNameLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
    lbl.textColor = .white
    lbl.textAlignment = .center
    lbl.text = "Aqua"
    return lbl
  }()
  
  let classDateAndTimeLbl: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
    lbl.textColor = .white
    lbl.textAlignment = .center
    lbl.text = "25th March 2017 - 14:30"
    return lbl
  }()
  
  let descriptionView: UIView = {
    let v = UIView()
    v.backgroundColor = .white
    v.layer.shadowColor = UIColor.black.cgColor
    v.layer.shadowOpacity = 0.5
    v.layer.shadowOffset = CGSize(width: -1, height: 1)
    v.layer.shadowRadius = 1
    return v
  }()
  
  let descriptionTextView: UITextView = {
    let v = UITextView()
    v.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    v.isEditable = false
    return v
  }()
  
  let classDescriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "A full body workout that requires strength, stamina and a steally determination - great fun though!"
    lbl.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    lbl.textColor = .black
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    return lbl
  }()
  
  let textView: UIView = {
    let v = UIView()
    v.backgroundColor = .yellow
    return v
  }()
  
  let editClassButton: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .purple
    btn.alpha = 0.6
    let image = UIImage(named: "edit")
    btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    btn.clipsToBounds = true
    btn.contentMode = .scaleAspectFill
    btn.layer.cornerRadius = 5
    btn.addTarget(self, action: #selector(handleEditClassBooking), for: .touchUpInside)
    return btn
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchClassesAttending()
    
    view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    tabBarController?.tabBar.isHidden = true
    self.navigationController?.navigationBar.isHidden = true
    
    collectionView.register(ClassDetailInfoTimeCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(ClassLevelCell.self, forCellWithReuseIdentifier: "cellId2")
    collectionView.register(ClassAvailabilityCell.self, forCellWithReuseIdentifier: "cellId3")
    collectionView.delegate = self
    collectionView.dataSource = self
    
    view.addSubview(infoView)
    view.addSubview(descriptionView)
    view.addSubview(collectionView)
    view.addSubview(classNameLabel)
    view.addSubview(classDateAndTimeLbl)
    view.addSubview(descriptionTextView)
    view.addSubview(classDescriptionLabel)
    
    
    classDescriptionLabel.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    
    collectionView.anchor(top: descriptionView.topAnchor, left: descriptionView.leftAnchor, bottom: descriptionView.bottomAnchor, right: descriptionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    descriptionTextView.anchor(top: descriptionView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    classDateAndTimeLbl.anchor(top: classNameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    classDateAndTimeLbl.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
    
    classNameLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    classNameLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
    classNameLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
    
    descriptionView.anchor(top: infoView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: view.frame.width, height: 100)
    
    infoView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 250)
  }
  
  fileprivate func reanchorViewsIfNotAttedningClass() {
    view.addSubview(acceptButton)
    view.addSubview(editClassButton)
    view.addSubview(declineButton)
    
    acceptButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 120, height: 40)
    
    
    declineButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 120, height: 40)
    
  }
  
  fileprivate func reanchorViews() {
    view.addSubview(editClassButton)
    view.addSubview(declineButton)
    
    editClassButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 40)
    declineButton.anchor(top: nil, left: editClassButton.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 40, height: 40)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClassDetailInfoTimeCell
      cell.timeOfClassLabel.text = classes?.classDuration
      print("CELLLLL \(classes?.classDuration)")
      return cell
    } else if indexPath.item == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath) as! ClassLevelCell
      cell.levelOfClassLabel.text = classes?.classLevel
      return cell
    } else if indexPath.item == 2 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId3", for: indexPath) as! ClassAvailabilityCell
      cell.classAvailabilityLabel.text = "\(classes?.classAvailability ?? 0) spaces"
      return cell
    }
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID4", for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 3) / 3
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  @objc func handleEditClassBooking() {
    let editClassVC = EditClassViewController()
    editClassVC.classToEdit = self.classAttending
    self.navigationController?.pushViewController(editClassVC, animated: true)
  }
  
  @objc func handleDecline() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func handleSignUpToClass() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let classUID = classes?.classUID else { return }
    guard let classDate = classes?.classDate else { return }
    
    let classToAttend: Dictionary<String, Any>
    classToAttend = ["className": self.classes?.className ?? "",
                     "classUID": classUID,
                     "classDescription": self.classes?.classDescription ?? "",
                     "classLocation": self.classes?.classLocation ?? ""]
    
    guard let className = self.classes?.className else { return }
    guard let classDescription = self.classes?.classDescription else { return }
    
    Database.database().reference().child("classesUsersAttending").child(uid).child(classDate).setValue(classToAttend) { (err, _) in
      if let _ = err {
        print("Unable to upload the class")
        return
      }
      
      DataService.sharedInstance.updateValues(name: className, uid: classUID, newValue: -1, completionBlock: {
           print("This has worked!")
      })

      guard let classDuration = self.classes?.classDuration else { return }
      guard let dateString = self.classes?.classDate else { return }
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
      guard let dateToAdd = dateFormatter.date(from: dateString) else { return }
      print("POO :\(dateToAdd)")
      
      // This calls the function that adds the data to the users calendar regarding the clas they have just signed up for
      self.addEventToCalendar(title: className, description: classDescription, startDate: dateToAdd, endDate: dateToAdd , completion: { (done, err) in
        if err == nil {
          print("Successfully saved")
          
        }
      })
      
      let mainTab = TabBarController()
      self.present(mainTab, animated: true, completion: nil)
      
    }
  }
  
  fileprivate func fetchClassesAttending() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("classesUsersAttending").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print("HALALA \(snapshot.value ?? "")")
      if snapshot.exists() {
        print("User has attended a class before")
    } else {
      print("There is no user")
        self.reanchorViewsIfNotAttedningClass()
      }
      
      guard let classDict = snapshot.value as? [String: Any] else { return }
      classDict.forEach({ (arg) in
        let (key, _) = arg
        self.classDate.append(key)
        print("WOBBLY \(key)")
      })
      self.isUserAttendingThisClass()
    }) { (err) in
      print("Error fetching these classes", err)
    }
  }
  
  var classAttending: ClassesAttending?
  
  fileprivate func isUserAttendingThisClass() {
    print("DADADA\(classDate)")
    guard let classDate = self.classes?.classDate else { return }

    if self.classDate.contains(classDate) {
      
      let values = ["classUID": classes?.classUID,
                    "classDescription": classes?.classDescription,
                    "className": classes?.className,
                    "classLocation": classes?.classLocation]
      
      self.classAttending = ClassesAttending(classDate: classDate, dictionary: values)
      
      self.reanchorViews()
    } else {
      self.reanchorViewsIfNotAttedningClass()
    }
  }
  
//  fileprivate func updateTotalNumberOfClassPlacesAvailable(className: String, completionBlock: @escaping (() -> Void)) {
//    guard let UID = classes?.classUID else { return }
//    let ref = Database.database().reference().child("classes").child(className).child(UID).child("classAvailability")
//
//    print("HOLA \(ref)")
//
//    ref.runTransactionBlock({ (result) -> TransactionResult in
//      if let initialValue = result.value as? Int {
//        print("STEVE \(initialValue)")
//        result.value = initialValue - 1
//        return TransactionResult.success(withValue: result)
//      } else {
//        print("Not happening")
//        return TransactionResult.success(withValue: result)
//      }
//    }) { (err, completion, snapshot) in
//      print(err?.localizedDescription ?? "")
//      print(completion)
//      print(snapshot ?? "")
//      if !completion {
//        print("Unable to update the availability node")
//      } else {
//        completionBlock()
//      }
//    }
//
//  }
  
  // Adds the class to users device Calendar
  func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    let eventStore = EKEventStore()
    
    eventStore.requestAccess(to: .event) { (granted, err) in
      if (granted) && (err == nil) {
        print("Permission is granted")
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.notes = description
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
          try eventStore.save(event, span: .thisEvent)
        } catch let e as NSError {
          print("An error occorued: \(e)")
          
        } catch {
          print("an error occured")
        }
        print("Hello")
      } else {
        print("hello")
      }
    }
  }
  
}
