//
//  UsersManager.swift
//  Invite
//
//  Created by User1 on 09.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

class UserManager{
    
    static let sharedInstance = UserManager()
    private init(){}
    
    func setUserData(userData : UserProfile){
        UserService.sharedInstance.setUserData(userData: userData)
    }
    
    func getUserDataById(userData : UserProfile, completionHandler: @escaping (UserProfile?,Error?) -> Void){
        let userId = userData.userId
        UserService.sharedInstance.getUserDataById(userId: userId, completionHandler: { (userProfile, error) in
            guard userProfile != nil else{return completionHandler(nil, error)}
            return completionHandler(userProfile, nil)
        })
    }
}
