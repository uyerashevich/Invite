//
//  ProfileCacheManager.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

class ProfileCacheManager {
    
    
    
    static let sharedInstance = ProfileCacheManager()
    static let userProfileName = "UserProfile"
    var storedUserProfile : UserProfile?
    
    private init(){
    }
    
    var currentProfile : UserProfile? {
        get{
            guard let currentValue = storedUserProfile else {
                guard let data = Cache.load(userAccountString: ProfileCacheManager.userProfileName, UserProfile.self) else {return nil}
                storedUserProfile = data
                return data
            }
            return currentValue
        }
        set{
            if let userProfileValue = newValue {
                Cache.save(userAccountString: ProfileCacheManager.userProfileName, userProfileValue)
                storedUserProfile = userProfileValue
            } else {
                Cache.clear(userAccountString: ProfileCacheManager.userProfileName, UserProfile.self)
                storedUserProfile = nil
            }
        }
    }
    
    func loadCurrentProfile() -> Bool {
        
        guard let data = Cache.load(userAccountString: ProfileCacheManager.userProfileName, UserProfile.self) else {return false}
        storedUserProfile = data
        if let _ = storedUserProfile  {
            
            return true
        }else{
            return false
        }
        
    }
    
}
