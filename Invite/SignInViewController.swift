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
        //вход по умолчанию
        rememberUser = UserDefaults.standard.bool(forKey: "remember")
        if rememberUser && UserDefaults.standard.string(forKey: "userId") != nil && UserDefaults.standard.string(forKey: "userId") != "" && UserDefaults.standard.string(forKey: "email") != nil && UserDefaults.standard.string(forKey: "email") != ""
        {
            startActivityIndicator(viewController: self)
            userData.userId = UserDefaults.standard.string(forKey: "userId")!
            userData.email = UserDefaults.standard.string(forKey: "email")!
            
            
 //firebase  USER
            FirebaseUser.init().getUserData(userData: userData, completionHandler: { (userProfile) in
                self.userData = userProfile
                self.performSegue(withIdentifier: "goToUserCab", sender: self)
            })
     //firebase  EVENT
            var eventData  = EventData()
            eventData.ownerUserId = userData.userId
            FirebaseEvent.init().getAllEvent(completion: { (eventList) in
                
            })
//            FirebaseEvent.init().getEventData(eventData: eventData) { (eventArray) in
//
//                EventList.sharedInstance.eventList.append(eventArray)
//                print(EventList.sharedInstance.eventList.count)
//               // eventDataArray.append(eventArray)
////                print(eventArray)
////                print(eventDataArray.count)
//            }
            
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    
    @IBAction func signInGoogleButton(_ sender: Any) {
        startActivityIndicator(viewController: self)
        let signIn = GIDSignIn.sharedInstance()
        signIn?.signOut()
        signIn?.signIn()
    }
  
    @IBAction func facebookButton(_ sender: AnyObject) {
        AuthUser.init().facebookSignIn(view: self)
        
    }
    func forSeque(completionHandler: () -> Void){
        self.performSegue(withIdentifier: "goToUserCab", sender: self)
    }
}
