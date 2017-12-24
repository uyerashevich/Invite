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

class SignInViewController:  BaseViewController , GIDSignInUIDelegate {
    
    @IBOutlet weak var signInFacebookOutlet: UIButton!
    @IBOutlet weak var signInGoogleOutlet: UIButton!
    
   
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                                  object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //        GIDSignIn.sharedInstance().signInSilently()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignInViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
        toggleAuthUI()
        
    }
    
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            //вход по умолчанию
            if UserDefaults.standard.string(forKey: "userId") != nil && UserDefaults.standard.string(forKey: "userId") != ""{
                startActivityIndicator(viewController: self)
                let xz = UserDefaults.standard.string(forKey: "userId")
                FirebaseUser.init().getUserDataById(userId: xz!, completionHandler: { (resp) in
                    self.userProfile = resp
                    self.performSegue(withIdentifier: "goToUserCab", sender: self)
                })
            }
        } else {
            print("---NOT GOOGLE---")
        }
    }
    
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    @IBAction func signInGoogleButton(_ sender: Any) {
        startActivityIndicator(viewController: self)
        let signIn = GIDSignIn.sharedInstance()
        signIn?.signOut()
        signIn?.signIn()
    }
    
    @IBAction func facebookButton(_ sender: AnyObject) {
        startActivityIndicator(viewController: self)
        AuthManager.sharedInstance.facebookSignIn(view: self)
      //  AuthUser.init().facebookSignIn(view: self)
    }
}
