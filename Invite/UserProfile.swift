//
//  UserProfile.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

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
  //  var foto : Data?//10
    
    
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
    
    }
    
    func convertToDictionary()-> [String: Any] {
        return["userId": self.userId,"email": self.email, "aboutMe": self.aboutMe, "name": self.name,"sex": self.sex, "sexFavorite": self.sexFavorite, "surname": self.surname, "age": self.age, "instagramUrl": self.instagramUrl]

    }
//    required init?(fromDictionary: [String : Any]) {
//        guard let userId = fromDictionary["userId"] as? String,
//            let email = fromDictionary["email"] as? String,
//          //  let phone = fromDictionary["phone"] as? String,
//            let name = fromDictionary["name"] as? String,
//             let sex = fromDictionary["sex"] as? String,
//            let sexFavorite = fromDictionary["sexFavorite"] as? String,
//            let surname = fromDictionary["surname"] as? String,
//            let age = fromDictionary["age"] as? String,
//            let instagramUrl = fromDictionary["instagramUrl"] as? String,
//            let foto = fromDictionary["foto"] as? Data
//        else {
//                return nil}
//
//        self.userId = userId
//        self.email = email
//      //  self.phone = phone
//        self.name = name
//        self.sex = sex
//        self.sexFavorite = sexFavorite
//        self.surname = surname
//        self.age = age
//        self.instagramUrl = instagramUrl
//        self.foto = foto
//    }
}
