//
//  UserProfile.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit

class UserProfile{
    
    static let sharedInstance = UserProfile()
    
    var userId: String
    var email : String
    var aboutMe : String
    var name : String
    var sex : String
    var sexFavorite : String
    var surname : String
    var age : String
    var instagramUrl : String
    var foto : UIImage
   
    
    
private    init (){
        userId = ""
        email = ""
    aboutMe = ""
        name = ""
        sex = ""
        sexFavorite = ""
        surname = ""
        age = ""
        instagramUrl = ""
        foto = #imageLiteral(resourceName: "pixBlack")
    }
    
    func clear(){
        userId = ""
        email = ""
        aboutMe = ""
        name = ""
        sex = ""
        sexFavorite = ""
        surname = ""
        age = ""
        instagramUrl = ""
        foto = #imageLiteral(resourceName: "pixBlack")
        
    }
    func convertToDictionary()-> [String: Any] {
        return["userId": self.userId,"email": self.email, "aboutMe": self.aboutMe, "name": self.name,"sex": self.sex, "sexFavorite": self.sexFavorite, "surname": self.surname, "age": self.age, "instagramUrl": self.instagramUrl]

    }
}
