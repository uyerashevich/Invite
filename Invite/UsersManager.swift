//
//  UsersManager.swift
//  Invite
//
//  Created by User1 on 09.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

import Foundation

class  UsersManager{
    
    static let sharedInstanse = UsersManager()
    private init(){}
    
    
    func getAllUsers()->[UserProfile]?{
        
        return nil
    }
    func getUserById(userId : String,completionHandler: @escaping (UserProfile) -> Void) {
        FirebaseUser.init().getUserDataByID(userId: userId) { (userProfile) in
            print("UsersManager------------------------------")
            completionHandler(userProfile)
        }
    }
    
    func getUserByName()->UserProfile?{
        
        return nil
    }
    
}
