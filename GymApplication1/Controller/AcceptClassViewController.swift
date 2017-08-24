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

class AcceptClassViewController: UIViewController {
  
  var timeStamp: String?
  
  var classes: Classes? {
    didSet {
      classNameLabel.text = classes?.className
    }
  }
  
  let backgroundView: UIView = {
    let v = UIView()
    //v.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    v.backgroundColor = .yellow
    return v
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
    return lbl
  }()
  
  let classDateAndTimeLbl: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFont(name: "HelveticaNeue-Regular", size: 28)
    lbl.textColor = .white
    lbl.textAlignment = .center
    return lbl
  }()
  
  let descriptionView: UIView = {
    let v = UIView()
    v.backgroundColor = .blue
    return v
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //view.backgroundColor = UIColor.rgb(red: 229, green: 229, blue: 229)
    
    view.addSubview(backgroundView)
    view.addSubview(acceptButton)
    view.addSubview(declineButton)
    view.addSubview(infoView)
    view.addSubview(classNameLabel)
    view.addSubview(classDateAndTimeLbl)
    backgroundView.addSubview(descriptionView)
    
    backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
    
    acceptButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 120, height: 40)
    
    declineButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 120, height: 40)
    
    infoView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 250)
    //infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
   classNameLabel.anchor(top: nil, left: nil, bottom: infoView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)

  }
  
  @objc func handleDecline() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handleSignUpToClass() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let classUID = classes?.classUID else { return }
    
    let classToAttend: Dictionary<String, Any>
    classToAttend = ["className": self.classes?.className ?? "",
                     "classDate": self.classes?.classDate ?? "",
                     "classDescription": self.classes?.classDescription ?? ""]
    
    guard let className = self.classes?.className else { return }
    guard let classDescription = self.classes?.classDescription else { return }
    
    Database.database().reference().child("users").child(uid).child("classesAttending").child(classUID).setValue(classToAttend) { (err, _) in
      if let _ = err {
        print("Unable to upload the class to the DB")
        return
      }
      
      self.updateTotalNumberOfClassPlacesAvailable(className: className, completionBlock: {
        print("Updated count")
      })
      
      
      let userAttending: Dictionary<String, Any>
      userAttending = ["userAttending": uid]
      
      Database.database().reference().child("classes").child(className).child(classUID).child("attendees").setValue(userAttending)
      
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
  
  fileprivate func updateTotalNumberOfClassPlacesAvailable(className: String, completionBlock: @escaping (() -> Void)) {
    guard let UID = classes?.classUID else { return }
    let ref = Database.database().reference().child("classes").child(className).child(UID).child("classAvailability")
    
    print("HOLA \(ref)")
    
    ref.runTransactionBlock({ (result) -> TransactionResult in
      if let initialValue = result.value as? Int {
        print("STEVE \(initialValue)")
        result.value = initialValue - 1
        return TransactionResult.success(withValue: result)
      } else {
        print("Not happening")
        return TransactionResult.success(withValue: result)
      }
    }) { (err, completion, snapshot) in
      print(err?.localizedDescription ?? "")
      print(completion)
      print(snapshot ?? "")
      if !completion {
        print("Unable to update the availability node")
      } else {
        completionBlock()
      }
    }
    
  }
  
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
