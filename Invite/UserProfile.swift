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
    var socialName: String
    var userId: String
    var email : String
    var aboutMe : String
    var name : String
    var sex : String
    var sexFavorite : String
    var surname : String
    var age : String
    var instagramUrl : String
    var favoriteEvents : [String]
    var fotoUrl : [String]
  //  var socialFotoUrl : String
   
//    let urlString = "file:///Users/Documents/Book/Note.txt"
//    let pathURL = URL(string: urlString)!
//    print("the url = " + pathURL.path)
    
private    init (){
        socialName = ""
        userId = ""
        email = ""
    aboutMe = ""
        name = ""
        sex = ""
        sexFavorite = ""
        surname = ""
        age = ""
        instagramUrl = ""
    fotoUrl = []
    favoriteEvents = []
    //socialFotoUrl = ""
  
    }
    
    func clear(){
        socialName = ""
        userId = ""
        email = ""
        aboutMe = ""
        name = ""
        sex = ""
        sexFavorite = ""
        surname = ""
        age = ""
        instagramUrl = ""
        fotoUrl = []
        favoriteEvents = []
       //socialFotoUrl = ""
    }
    func convertToDictionary()-> [String: Any] {
        var arrayUrl :[String] = []
        for i in fotoUrl{
            arrayUrl.append(i)
        }
        var arrayfavoriteEvents :[String] = []
        for i in favoriteEvents{
            arrayfavoriteEvents.append(i)
        }
        return["socialName": self.socialName, "userId": self.userId,"email": self.email, "aboutMe": self.aboutMe, "name": self.name,"sex": self.sex, "sexFavorite": self.sexFavorite, "surname": self.surname, "age": self.age, "instagramUrl": self.instagramUrl ,"fotoUrl": arrayUrl, "favoriteEvents": arrayfavoriteEvents]//, "socialFotoUrl": self.socialFotoUrl]
    }
}
