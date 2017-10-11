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
                

                GIDSignIn.sharedInstance().uiDelegate = self
  
            }
    
            @IBAction func signInGoogleButton(_ sender: Any) {
                let signIn = GIDSignIn.sharedInstance()
                signIn?.signOut()
                signIn?.signIn()
            }
            
            @IBAction func facebookButton(_ sender: AnyObject) {
   
                AppDelegate.checkerFG = 1
                
                let facebookLogin = FBSDKLoginManager()
                
                facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (facebookResult, facebookError) in
                    if facebookError != nil {
                        
                        displayAlertMessage(messageToDisplay: "There was an error logging in to Facebook. Error: \(facebookError)", viewController: self)
                    } else
                        if (facebookResult?.isCancelled)!
                        {
                            print("Facebook login was cancelled!")
                        }
                        else {
            
                            let credential = (FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString))
                            
                            //signin in Firebase
                            Auth.auth().signIn(with: credential, completion: { (user, error) in
                                print("user signed into firebase")
                                
                                if user != nil{
                                    print (user?.email)
                                   
                                    self.performSegue(withIdentifier: "goToPaty", sender: self)
                        
                                    
                                }else{
                                    //error: check error and show message
                                    displayAlertMessage(messageToDisplay: "Проверьте подключение к интернету ", viewController: self )
                                    
                                }
                            })
                    }
                }
            }
            
            
            
            
            
}
