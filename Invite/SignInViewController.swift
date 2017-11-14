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


class SignInViewController:  BaseViewController ,GIDSignInUIDelegate {

    var rememberUser: Bool = false
    @IBOutlet weak var rememberButtonOutlet: UIButton!
    @IBOutlet weak var signInButtonOutlet: UIButton!
    var userData = UserProfile.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberUser = UserDefaults.standard.bool(forKey: "remember")
        if rememberUser && UserDefaults.standard.string(forKey: "userId") != nil && UserDefaults.standard.string(forKey: "userId") != "" && UserDefaults.standard.string(forKey: "email") != nil && UserDefaults.standard.string(forKey: "email") != ""
        {
              startActivityIndicator(viewController: self)
            userData.userId = UserDefaults.standard.string(forKey: "userId")!
            userData.email = UserDefaults.standard.string(forKey: "email")!
            FirebaseUser.init().getUserData(userData: userData, completionHandler: { (userProfile) in
                self.userData = userProfile
                self.performSegue(withIdentifier: "goToUserCab", sender: self)
            })
        }
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func signInGoogleButton(_ sender: Any) {
        startActivityIndicator(viewController: self)
        let signIn = GIDSignIn.sharedInstance()
        signIn?.signOut()
        signIn?.signIn()
    }
    
//    @IBAction func rememberButton(_ sender: UIButton) {
//        if !rememberUser  {
//            rememberButtonOutlet.setImage(#imageLiteral(resourceName: "v"), for: .normal)
//            rememberUser = true
//            UserDefaults.standard.set(rememberUser, forKey:"remember")
//        }else{
//            rememberButtonOutlet.setImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
//            rememberUser = false
//            UserDefaults.standard.set(rememberUser, forKey:"remember")
//        }
//    }
    @IBAction func facebookButton(_ sender: AnyObject) {
        AuthUser.init().facebookSignIn(view: self)
        
    }
    func rememberUserFunc(){
      
    }
}
