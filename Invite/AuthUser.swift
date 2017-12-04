//
//  AuthUser.swift
//  Invite
//
//  Created by User1 on 13.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FBSDKLoginKit

class  AuthUser {
    
    static let sharedInstance = AuthUser()
    
    func facebookSignIn(view: UIViewController){
        AppDelegate.checkerFG = 1
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: view) { (facebookResult, facebookError) in
            if facebookError != nil {
                
                displayAlertMessage(messageToDisplay: "There was an error logging in to Facebook. Error: \(facebookError)", viewController: view)
            } else if (facebookResult?.isCancelled)!
            {
                
                print("Facebook login was cancelled!")
            }
            else {
                
                let credential = (FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString))
                
                //signin in Firebase
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    print("user signed into firebase")
                    // print(error)
                    if user != nil{
                        
                        startActivityIndicator(viewController: view)
                        
                        var userData = UserProfile.sharedInstance
                        //firebase  USER
                        userData.email = (user?.email)!
                        userData.userId = (user?.uid)!
                        let urlUserPhoto = user?.photoURL
                        var foto : UIImage = #imageLiteral(resourceName: "pixBlack")
                        getImageFromWeb((urlUserPhoto?.absoluteString)!, closure: { (userPhotoUIImg) in
                            foto = userPhotoUIImg!
                         
                        })
                      
                        FirebaseUser.init().getUserData(userData: userData, completionHandler: { (userProfile) in
                            userData = userProfile
                          
                            if userData.name == "" {
                              
                                
                                userData.name = (user?.displayName)!
                                userData.foto = foto
                                //firebase USER SET
                                FirebaseUser.init().setUserData(userData: userData)
                               // FirebaseUser.init().setUserData(userId: (user?.uid)!, userEmail: (user?.email)!)
                                
                            }
                            view.performSegue(withIdentifier: "goToUserCab", sender: view)
                        })
                        UserDefaults.standard.set( user?.uid, forKey: "userId")
                        UserDefaults.standard.set( user?.email, forKey: "email")
                        
                            FirebaseEvent.init().getListEvent(completion: { (eventArray) in
                            EventList.sharedInstance.eventList.append(eventArray)
                            print(EventList.sharedInstance.eventList.count)
                        })
                    }else{
                        //error: check error and show message
                        displayAlertMessage(messageToDisplay: "Facebook login was canceled ", viewController: view )
                    }
                })
            }
        }
    }
    
    
    
    func signInUser(userEmail : String, userPassword : String, view: UIViewController){
        
        //signin in Firebase.google.com
        Auth.auth().signIn(withEmail:  userEmail, password: userPassword, completion: { (user, error) in
            if user != nil {
                view.performSegue(withIdentifier: "goToPaty", sender: view)
            }
            else{
                //error: check error and show message
                displayAlertMessage(messageToDisplay: "Verify you pass or login ", viewController: view )
                return
            }
        })
    }
    
    
    func signUpUser (userEmail : String, userPassword : String, reUserPassword: String, view: UIViewController){
        
        //valid pass
        guard (userPassword == reUserPassword) else{
            displayAlertMessage(messageToDisplay: "Enter the password again",viewController: view)
            return
        }
        
        //regisration in Firebase Firabase.google.com
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion:  { (user, error) in
            //check that user not nil
            if (user != nil) {
                view.performSegue(withIdentifier: "goToPaty", sender: view)
            }
            else {
                //error: check error and show mess
                displayAlertMessage(messageToDisplay: "This user already exists" , viewController: view)
            }
        })
    }
    
    func validLoginPassword(userEmail: String,userPassword :String )->Bool{
        
        //valid email
        let finalEmail = userEmail.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let isEmailAddresValid = isValidEmailAddress(emailAddressString: finalEmail)
        guard isEmailAddresValid else{
            // displayAlertMessage(messageToDisplay: "Email addres is not valid",viewController: self)
            return false
        }
        // valid on >6 char in pass for Firebase
        guard (userPassword.characters.count) > 5 else{
            //  displayAlertMessage(messageToDisplay: "Password must be longer than 6 characters", viewController: self)
            return false
        }
        return true
    }
    
    
    
    
    
}
