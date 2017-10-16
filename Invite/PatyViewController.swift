//
//  PatyViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class PatyViewController: UIViewController {
    
    
    
    @IBOutlet weak var sexOutlet: UISegmentedControl!
    @IBOutlet weak var orientationOutlet: UISegmentedControl!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var surnameTexField: UITextField!
 
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    @IBAction func saveButton(_ sender: UIButton) {
        
        switch orientationOutlet.selectedSegmentIndex {
        case 1: AppDelegate.userProfile.sexFavorite = "gay"
        case 2 : AppDelegate.userProfile.sexFavorite = "lesbian"
        default : AppDelegate.userProfile.sexFavorite = "natural"
        }
        switch sexOutlet.selectedSegmentIndex{
            case 1: AppDelegate.userProfile.sex = "women"
        default : AppDelegate.userProfile.sex = "men"
        }
        if ageTextField.text != nil{  AppDelegate.userProfile.age = ageTextField.text! }
        if nameTextField.text != nil{ AppDelegate.userProfile.name = nameTextField.text!}
        if surnameTexField.text != nil {AppDelegate.userProfile.surname = surnameTexField.text!}

        FirebaseUserModel.init().setUserData(userData: AppDelegate.userProfile)
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
