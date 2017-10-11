//
//  SignUpViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController { //, UITextFieldDelegate
    
    @IBOutlet weak var rememberButtonOutlet: UIButton!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        
        let userEmail = loginTextField.text!.lowercased()
        let userPassword = passwordTextField.text
        let reUserPassword = rePasswordTextField.text
        //valid email
        let finalEmail = userEmail.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let isEmailAddresValid = isValidEmailAddress(emailAddressString: finalEmail)
        guard isEmailAddresValid else{
            displayAlertMessage(messageToDisplay: "Email addres is not valid",viewController: self)
            return
        }
        // valid on >6 char in pass for Firebase
        guard (passwordTextField.text?.characters.count)! > 5 else{
            displayAlertMessage(messageToDisplay: "Password must be longer than 6 characters", viewController: self)
            return
        }
        
        signUpUser(userEmail: userEmail, userPassword: userPassword!, reUserPassword: reUserPassword!)
//        signInUser(userEmail: userEmail, userPassword: userPassword)
        
    }
    
    func signUpUser (userEmail : String, userPassword : String, reUserPassword: String){
        
        //valid pass
        guard (userPassword == reUserPassword) else{
            displayAlertMessage(messageToDisplay: "Enter the password again",viewController: self)
            return
        }
        
        //regisration in Firebase Firabase.google.com
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion:  { (user, error) in
            //check that user not nil
            if (user != nil) {
                
                
                self.loginTextField.text = ""
                self.passwordTextField.text = ""
                self.rePasswordTextField.text = ""
                
                self.performSegue(withIdentifier: "goToPaty", sender: self)
                
            }
            else {
                //error: check error and show mess
                displayAlertMessage(messageToDisplay: "This user already exists" , viewController: self)
            }
        })
    }
    
    func signInUser(userEmail : String, userPassword : String){
        
        //signin in Firebase.google.com
        Auth.auth().signIn(withEmail:  userEmail, password: userPassword, completion: { (user, error) in
            
            if user != nil {
                
              
                self.passwordTextField.text = ""
                self.passwordTextField.text = ""
                self.rePasswordTextField.text = ""
                self.performSegue(withIdentifier: "goToPaty", sender: self)
                
            }
            else{
                //error: check error and show message
                displayAlertMessage(messageToDisplay: "Verify you pass or login ", viewController: self )
                return
            }
        })
    }
    @IBAction func backButton(_ sender: UIButton) {
        rePasswordTextField.text = ""
        passwordTextField.text = ""
        loginTextField.text = ""
        dismiss(animated: true, completion: nil)
    }
    @IBAction func rememberButton(_ sender: UIButton) {
        rememberButtonOutlet.setImage(#imageLiteral(resourceName: "v"), for: .normal)
       // rememberUser = true
        //   UserDefaults.standard.set(true, forKey:"remember")
        
    }
    
}
