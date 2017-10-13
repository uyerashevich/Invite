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
    var rememberUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func okButton(_ sender: UIButton) {
        
        let userEmail = loginTextField.text!.lowercased()
        let userPassword = passwordTextField.text
        let reUserPassword = rePasswordTextField.text
        
        if AuthUser.init().validLoginPassword(userEmail: userEmail, userPassword: userPassword!){
            AuthUser.init().signUpUser(userEmail: userEmail, userPassword: userPassword!, reUserPassword: reUserPassword!, view: self)
        }else {
            displayAlertMessage(messageToDisplay: "Failed password or login",viewController: self)
            return
        }
        
    }
   
    
    @IBAction func backButton(_ sender: UIButton) {
        rePasswordTextField.text = ""
        passwordTextField.text = ""
        loginTextField.text = ""
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func rememberButton(_ sender: UIButton) {
        if !rememberUser {
            rememberButtonOutlet.setImage(#imageLiteral(resourceName: "v"), for: .normal)
            rememberUser = true
            UserDefaults.standard.set(true, forKey:"remember")
        }else{
            rememberButtonOutlet.setImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            rememberUser = false
            UserDefaults.standard.set(false, forKey:"remember")
        }
    }
    
    
    
    
    
    
    
}
