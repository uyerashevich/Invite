//
//  UserService.swift
//  Invite
//
//  Created by User1 on 09.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

class UserService{
    
    static let sharedInstance = UserService()
    private init(){}
 
    func setUserData(userData : UserProfile){
        FirebaseUser.sharedInstance.updateUserData(userData: userData)
    }
    
    func getUserDataById(userId : String, completionHandler: @escaping (UserProfile?,Error?) -> Void){
        FirebaseUser.sharedInstance.getUserDataById(userId: userId, completionHandler: { (user,error)  in
            guard user != nil else{return completionHandler(nil, "Wrong user - data" as! Error)}
            return completionHandler(user, nil)
        })
    }
}

