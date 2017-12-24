//
//  AppDelegate.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//
//


import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import GoogleMaps
import GooglePlaces



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate{
    
    
    var window: UIWindow?
    var databaseRef: DatabaseReference!
    static var checkerFG : Int = 0
    static var activityIndicator = UIActivityIndicatorView()
    static var ref: DatabaseReference? = Database.database().reference()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyBNPyUGQqLODQGKw0OljeNZNtv7PmKJf6A")
        GMSServices.provideAPIKey("AIzaSyBNPyUGQqLODQGKw0OljeNZNtv7PmKJf6A")
        FirebaseApp.configure()
      //  AppAppearance.SetUp()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if AppDelegate.checkerFG == 1{
            return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        }else{
            return true
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        switch AppDelegate.checkerFG {
        case 1: return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        case 0 :   return GIDSignIn.sharedInstance().handle(url,
                                                            sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                            annotation: [:])
        default : return true
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            
            print(error.localizedDescription)
            print("Ошибка входа в Google аккаунт попробуйте попозже")
            return
        }else{
            
            //            // Perform any operations on signed in user here.
            //            let userId = user.userID                  // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
            //            let email = user.profile.email
            //            print("\(userId)--\(fullName)--\(givenName)--\(familyName)--\(email)")
            //
            guard let authentication = user.authentication else {  print("Ошибка входа в Google ")
                return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            AuthManager.sharedInstance.authUser(credential: credential, completion: { (userProfile, error) in
                let userCabVC = BaseViewController()
                userCabVC.userProfile = userProfile!
                print(userCabVC.userProfile.name)
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                    object: nil, userInfo: ["statusText": "Signed in user:\n\(fullName)"])
            })
        }
    }
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil, userInfo: ["statusText": "User has disconnected."])
        print("DISCONNECT  GOOGLE")
    }
    // [END disconnect_handler]
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        // self.saveContext()
    }
    
    
}


