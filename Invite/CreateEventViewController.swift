//
//  CreateEventViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import GoogleMaps

class CreateEventViewController: BaseViewController, UITextFieldDelegate {
    
    let imagePick = ImagePickerActionSheet.init()
    
    @IBOutlet weak var imgMaskView: UIView!
    @IBOutlet weak var descriptionEventTextField: UITextField!
    @IBOutlet weak var subtitleEventTextField: UITextField!
    @IBOutlet weak var nameEventTextField: UITextField!
    @IBOutlet weak var dateEventTextField: UITextField!
    
    @IBOutlet weak var startTimeEventTextField: UITextField!
    @IBOutlet weak var endTimeEventTextField: UITextField!
    @IBOutlet weak var addressEventTextField: UITextField!
    @IBOutlet weak var contactPhoneEventTextField: UITextField!
    @IBOutlet weak var costEventTextField: UITextField!
    
    @IBOutlet weak var fotoEventImageView: UIImageView!
  
    @IBOutlet weak var approvedUserSlide: UISwitch!
    
    @IBOutlet weak var privateEventSlide: UISwitch!
    var eventData = EventData()
    var coordinatesEvent : CLLocationCoordinate2D?
   var nameSenderVC : String = "createEventVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        //для убирания клавы с экрана/////////
        self.descriptionEventTextField.delegate = self
        self.subtitleEventTextField.delegate = self
        self.nameEventTextField.delegate = self
        self.dateEventTextField.delegate = self
        
        self.startTimeEventTextField.delegate = self
        self.endTimeEventTextField.delegate = self
        self.addressEventTextField.delegate = self
        self.costEventTextField.delegate = self
        self.contactPhoneEventTextField.delegate = self
    }
    //для убирания клавы с экрана/////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func saveEventButton(_ sender: Any) {
        
        eventData.eventName = nameEventTextField.text!
        let userId = UserProfile.sharedInstance.userId
        eventData.ownerUserId = userId
        eventData.address = addressEventTextField.text!
        
        eventData.subTitle = subtitleEventTextField.text!
        eventData.descriptionEvent = descriptionEventTextField.text!
        eventData.date = dateEventTextField.text!
        
        
        eventData.startTime = startTimeEventTextField.text!
        eventData.endTime = endTimeEventTextField.text!
        eventData.cost = costEventTextField.text!
        
        if approvedUserSlide.isOn{eventData.approvedUser = "true"}else{eventData.approvedUser = "false"}
        if privateEventSlide.isOn{ eventData.everyone = "true"}else{ eventData.everyone = "false"}
        
        eventData.contactPhone = contactPhoneEventTextField.text!
//                eventData.locationLat = 
//                eventData.locationLong =
        eventData.eventImage = fotoEventImageView.image!
        
        
        FirebaseEvent.init().setEventData(eventData: eventData)
        
        clearAllTexfield()
        
    }
    func clearAllTexfield(){
        
        descriptionEventTextField.text = ""
       subtitleEventTextField.text = ""
        nameEventTextField.text = ""
        dateEventTextField.text = ""
        
       startTimeEventTextField.text = ""
        endTimeEventTextField.text = ""
        addressEventTextField.text = ""
       contactPhoneEventTextField.text = ""
        costEventTextField.text = ""
        fotoEventImageView.image = #imageLiteral(resourceName: "star_enabled")
        
    }
    @IBAction func tapImage(_ sender: Any) {
        imagePick.showCameraLibrary(view: self)
        imagePick.onDataUpdate = { [weak self] (image: UIImage) in
            let resizeImage = image.fixSize()
            self?.fotoEventImageView.image = resizeImage
            self?.eventData.eventImage = resizeImage
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    //ShowMaps
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMaps" {
            if let mapsVC = segue.destination as? MapBaseViewController {
             
                mapsVC.nameSenderVC = self.nameSenderVC
                
                mapsVC.callBackToCreateEvent = {[unowned self] (coordinateEvent) in
                    print(coordinateEvent.latitude)
                  
                    
                    self.eventData.locationLat = coordinateEvent.latitude
                    self.eventData.locationLong = coordinateEvent.longitude
                    
                }
            }
        }
    }
    
}
