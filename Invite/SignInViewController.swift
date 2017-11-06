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
    

     var rememberUser: Bool?
    @IBOutlet weak var rememberButtonOutlet: UIButton!
    @IBOutlet weak var signInButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        
        
         
        super.viewDidLoad()
        rememberUser = UserDefaults.standard.bool(forKey: "remember")
        if UserDefaults.standard.bool(forKey: "remember") {
            self.performSegue(withIdentifier: "goToPaty", sender: self)
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func signInGoogleButton(_ sender: Any) {
      
        let signIn = GIDSignIn.sharedInstance()
        signIn?.signOut()
        signIn?.signIn()
    }
   
    @IBAction func rememberButton(_ sender: UIButton) {
        if !rememberUser!  {
            rememberButtonOutlet.setImage(#imageLiteral(resourceName: "v"), for: .normal)
            rememberUser = true
            UserDefaults.standard.set(rememberUser, forKey:"remember")
        }else{
            rememberButtonOutlet.setImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            rememberUser = false
            UserDefaults.standard.set(rememberUser, forKey:"remember")
        }
    }
    @IBAction func facebookButton(_ sender: AnyObject) {
        AuthUser.init().facebookSignIn(view: self)
       
}
}
