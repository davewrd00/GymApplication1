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
  
  var classes: Classes? {
    didSet {
      print(classes?.className ?? "")
      
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
    
    return v
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
    print("POO \(classes?.classTime)")
    
    let classToAttend: Dictionary<String, Any>
    classToAttend = ["className": self.classes?.className ?? "",
                     "classDate": self.classes?.classDate ?? "",
                     "classDescription": self.classes?.classDescription ?? ""]
    
    guard let className = self.classes?.className else { return }
    guard let classDescription = self.classes?.classDescription else { return }
    
    Database.database().reference().child("users").child(uid).child("classesAttending").childByAutoId().setValue(classToAttend) { (err, _) in
      if let _ = err {
        print("Unable to upload class to user in DB")
        return
      }
      print("Successfully been able to add this to user in FB")
      
      guard let classDuration = self.classes?.classDuration else { return }
      guard let dateString = self.classes?.classDate else { return }
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm"
      guard let dateToAdd = dateFormatter.date(from: dateString) else { return }
      print("POO :\(dateToAdd)")
      
//      guard let timeInterval = Double(classDuration) else { return }
//      let endingDate = dateToAdd.addingTimeInterval(timeInterval)
//      print("DAVIDWARD \(endingDate)")
//
//      // Need to calculate how long the class is going to last so that I can then implement endDate in method call
//      guard let classDuration = self.classes?.classDuration else { return }
//      guard let timeInterval = Double(classDuration) else { return }
//      //let myNSDate = Date(timeIntervalSince1970: timeInterval)
//      let myDate = Date(timeIntervalSince1970: timeInterval)
//
//      print("DAVID: This is my NSDate object \(myDate)")
      
//      self.createMyTime(classDuration: classDuration)
//
      
      // This calls the function that adds the data to the users calendar regarding the clas they have just signed up for
      self.addEventToCalendar(title: className, description: classDescription, startDate: dateToAdd, endDate: dateToAdd , completion: { (done, err) in
        if err == nil {
          print("Successfully saved")
        }
      })
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
//  func createMyTime(classDuration: String)  {
//    print("DAVIDWARD \(classDuration)")
//    guard let timeInterval = Double(classDuration) else { return }
//    let myTime = Date(timeIntervalSince1970: timeInterval)
//    print("DAVIDWARD: \(myTime)")
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
