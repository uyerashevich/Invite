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
                
                userData.email = (user?.email)!
                userData.userId = (user?.uid)!
                userData.name = (user?.displayName)!
                userData.socialName = (user?.displayName)!
                

                if let foto2 = user?.photoURL?.absoluteString{ 
                    userData.fotoUrl.append(foto2) }
                
                FirebaseUser.init().getUserDataById(userId: userData.userId, completionHandler: { (userProfile) in
                    userData = userProfile
                    print("sftryt")
                    return completion(userData, nil)
                })
            }else{
                // completion(nil, error)
                print("Ошибка входа в Google аккаунт попробуйте попозже")
            }
        })
    }
}


                
    
