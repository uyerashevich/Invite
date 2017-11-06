//
//  UserViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class UserViewController: UIViewController {
    
    
    
    @IBOutlet weak var sexOutlet: UISegmentedControl!
    @IBOutlet weak var orientationOutlet: UISegmentedControl!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var surnameTexField: UITextField!

    @IBOutlet weak var nameTextField: UITextField!
    var eventDataArray = [EventData]()
    var eventData = EventData()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        eventData.ownerUserId = UserProfile.sharedInstance.userId
        
        FirebaseEvent.init().getEventData(eventData: eventData){ (result) -> () in
            //print(result.subTitle)
            self.eventData = result
            self.eventDataArray.append(result)
         

        }
        
        //print(eventDataArray.count)
//        for i in eventDataArr{
//            print("\(i.eventId)-]]++++]]--")
//            print("\(i.subTitle)-]]]+++++]--")
//            print(eventDataArr.count)
//        }
   }
    @IBAction func saveButton(_ sender: UIButton) {
        let userData = UserProfile.sharedInstance
        switch orientationOutlet.selectedSegmentIndex {
        case 1: userData.sexFavorite = "gay"
        case 2 : userData.sexFavorite = "lesbian"
        default : userData.sexFavorite = "natural"
        }
        switch sexOutlet.selectedSegmentIndex{
            case 1: userData.sex = "women"
        default : userData.sex = "men"
        }
        if ageTextField.text != nil{  userData.age = ageTextField.text! }
        if nameTextField.text != nil{ userData.name = nameTextField.text!}
        if surnameTexField.text != nil {userData.surname = surnameTexField.text!}

        FirebaseUser.init().setUserData(userData: userData)
    }

 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filters" {
            let destinationVC = segue.destination as! FiltersViewController
            destinationVC.eventDataArray = self.eventDataArray
        }
    }
@IBAction func backButton(_ sender: UIButton) {
    
    let firebaseAuth = Auth.auth()
    do {
        print("выход из Google")
        try firebaseAuth.signOut()
    } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
    }
    UserDefaults.standard.set(false, forKey:"remember")
    dismiss(animated: true, completion: nil)
    navigationController?.popViewController(animated: true)
}




}
