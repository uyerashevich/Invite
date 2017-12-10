//
//  AuthManager.swift
//  Invite
//
//  Created by User1 on 09.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit

class AuthManager{
    
    static let sharedInstance = AuthManager()
    private init(){}
    
    func authUser(credential: AuthCredential, completion: @escaping (_ userData: UserProfile?, Error?)->()){
       
        AuthService.sharedInstance.authUserInFirebase(credential: credential) { (userDataResponse, error) in
            UserDefaults.standard.set( userDataResponse?.userId, forKey: "userId")
            completion(userDataResponse, nil)
        }
    }
    
    func facebookSignIn(view: UIViewController){
        AppDelegate.checkerFG = 1
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["public_profile","email"], from: view) { (facebookResult, facebookError) in
            if facebookError != nil {
                
                displayAlertMessage(messageToDisplay: "There was an error logging in to Facebook. Error: \(facebookError)", viewController: view)
            } else if (facebookResult?.isCancelled)!{ print("Facebook login was cancelled!") }
            else {
                //   startActivityIndicator(viewController: view)
                //                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status, age_range"]).start(completionHandler: { (connection, result, error) -> Void in
                //                    if (error == nil){
                //                        let fbDetails = result as! NSDictionary
                //                        print(fbDetails)
                //                    }
                //                })
                let credential = (FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString))
                self.authUser(credential: credential, completion: { (userData, error) in
                    view.performSegue(withIdentifier: "goToUserCab", sender: view)
                })
            }
        }
    }
}

