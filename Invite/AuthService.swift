//
//  AuthService.swift
//  Invite
//
//  Created by User1 on 09.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService{
    
    static let sharedInstance = AuthService()
    private init(){}
    
    func authUserInFirebase(credential: AuthCredential, completion: @escaping (_ userData: UserProfile?, Error?)->()){
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            print("user signed into firebase")
            if user?.email != nil && user?.uid != nil {
                var userData = UserProfile.sharedInstance
                
                userData.foto = #imageLiteral(resourceName: "pixBlack")
                userData.email = (user?.email)!
                userData.userId = (user?.uid)!
                userData.name = (user?.displayName)!
                
                let urlUserPhoto = user?.photoURL
                getImageFromWeb((urlUserPhoto?.absoluteString)!, closure: { (userPhotoUIImg) in
                    userData.foto = userPhotoUIImg!
                    
                    FirebaseUser.init().getUserData(userData: userData, completionHandler: { (userProfile) in
                        userData = userProfile
                        completion(userData, nil)
                    })
                })
            }else{
                // completion(nil, error)
                print("Ошибка входа в Google аккаунт попробуйте попозже")
            }
        })
    }
}

