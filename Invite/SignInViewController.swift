//
//  SignInViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth
import Firebase


class SignInViewController:  UIViewController ,GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.string(forKey: "remember") == "true" ){
            self.performSegue(withIdentifier: "goToPaty", sender: self)
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func signInGoogleButton(_ sender: Any) {
        let signIn = GIDSignIn.sharedInstance()
        signIn?.signOut()
        signIn?.signIn()
    }
    
    @IBAction func facebookButton(_ sender: AnyObject) {
        
       
}
}
