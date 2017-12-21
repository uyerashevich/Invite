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
    
    //  static let sharedInstance = UserProfile()
    
    //    let urlString = "file:///Users/Documents/Book/Note.txt"
    //    let pathURL = URL(string: urlString)!
    //    print("the url = " + pathURL.path)
    
    var socialName : String
    var userId: String
    var email : String
    var name : String//имя
    var surname : String//фамилия
    
    var sex : String//пол
    var aboutMe : String//
    var dateBirth : String
    var phone : String
    
    var favoriteEvents : [String]? //выбр пати
    var fotoUrl : [URL]?
    
    var sexFavorite : String
    var instagramUrl : String
    
    init (){
        socialName = ""
        userId = ""
        email = ""
        name = ""
        surname = ""
        
        sex = ""
        aboutMe = ""
        dateBirth = ""
        phone = ""
        
        sexFavorite = ""
        instagramUrl = ""
    }
    
    func clear(){
        socialName = ""
        userId = ""
        email = ""
        name = ""
        surname = ""
        
        sex = ""
        aboutMe = ""
        dateBirth = ""
        phone = ""
        
        sexFavorite = ""
        instagramUrl = ""
        favoriteEvents = nil
        fotoUrl = nil
    }
    func convertToDictionary()-> [String: Any] {
        var array :[String] = []
        if favoriteEvents != nil{  for i in favoriteEvents!{
            array.append(i)
            }
        }
        var arrayUrl :[String] = []
        if fotoUrl != nil{  for i in fotoUrl!{
            arrayUrl.append(String(describing: i))
            }
        }
        return["socialName" : self.socialName,
               "userId": self.userId,
               "email": self.email,
               "name": self.name,
               "surname": self.surname,
               
               "sex": self.sex,
               "aboutMe": self.aboutMe,
               "dateBirth": self.dateBirth,
               "phone": self.phone,
               "favoriteEvents": array,
               "sexFavorite": self.sexFavorite,
               "instagramUrl": self.instagramUrl,
               "fotoUrl" : arrayUrl ]
    }
}
