//
//  SignInFirebaseViewController.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class SignInFirebaseViewController: UIViewController {


    @IBOutlet weak var rememberButtonOutlet: UIButton!
      var rememberUser = false
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        passwordTextField.text = ""
        loginTextField.text = ""
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func rememberButton(_ sender: UIButton) {
        rememberButtonOutlet.setImage(#imageLiteral(resourceName: "v"), for: .normal)
        rememberUser = true
        UserDefaults.standard.set(true, forKey:"remember")
    }
    
   
    @IBAction func okButton(_ sender: UIButton) {
        let userEmail = loginTextField.text!.lowercased()
        let userPassword = passwordTextField.text
        if validLoginPassword(userEmail: userEmail, userPassword: userPassword!){
            signInUser(userEmail: userEmail, userPassword: userPassword!, view: self)
        }else {
            displayAlertMessage(messageToDisplay: "Failed password or login",viewController: self)
            return
        }
    }
  

}
