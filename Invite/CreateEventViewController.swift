//
//  CreateEventViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    @IBOutlet weak var privateEventSlide: UISwitch!
    @IBOutlet weak var descriptionEventTextField: UITextField!//
    @IBOutlet weak var subtitleEventTextField: UITextField!//
    @IBOutlet weak var nameEventTextField: UITextField!//
    @IBOutlet weak var dateEventTextField: UITextField!
    @IBOutlet weak var startTimeEventTextField: UITextField!
    @IBOutlet weak var endTimeEventTextField: UITextField!
    @IBOutlet weak var freeOrPaidEventSlide: UISwitch!
    @IBOutlet weak var approvedUserSlide: UISwitch!
     @IBOutlet weak var contactPhoneEventTextField: UITextField!
    
    var eventData = EventData()
      var eventDataArr = [EventData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      
        // Do any additional setup after loading the view.
    }

    @IBAction func saveEventButton(_ sender: Any) {
        
        eventData.eventId = nameEventTextField.text!
        eventData.subTitle = subtitleEventTextField.text!
       // eventData.description = descriptionEventTextField.text!
        eventData.date = dateEventTextField.text!
        eventData.startTime = startTimeEventTextField.text!
        eventData.endTime = endTimeEventTextField.text!
         eventData.contactPhone = contactPhoneEventTextField.text!
        
        if freeOrPaidEventSlide.isOn {eventData.freeOrPaid = "true"}else{eventData.freeOrPaid = "false"}
        if approvedUserSlide.isOn{eventData.approvedUser = "true"}else{eventData.approvedUser = "false"}
        if privateEventSlide.isOn{ eventData.everyone = "true"}else{ eventData.everyone = "false"}
        
        let userId = UserProfile.sharedInstance.userId
        eventData.ownerUserId = userId
        
        eventData.eventId = nameEventTextField.text!
        FirebaseEvent.init().setEventData(eventData: eventData)
        
        
    }
   
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
}
