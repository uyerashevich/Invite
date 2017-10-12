//
//  UserDataModel.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

class UserProfile : Convertible{
    
    var password : String
    var email : String
    var phone : String
    var name : String
    var nikName : String
    
    func convertToDictionary()-> [String: Any] {
        return["password": self.password,"email": self.email, "phone": self.phone, "name": self.name,"nikName": self.nikName]
        
    }
    required init?(fromDictionary: [String : Any]) {
        guard let password = fromDictionary["password"] as? String,
            let email = fromDictionary["email"] as? String,
            let phone = fromDictionary["phone"] as? String,
            let name = fromDictionary["name"] as? String,
            let nikName = fromDictionary["nikName"] as? String else {
                return nil}
        
        self.password = password
        self.email = email
        self.phone = phone
        self.name = name
        self.nikName = nikName
    }
}
