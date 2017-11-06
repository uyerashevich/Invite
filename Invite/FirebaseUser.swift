//
//  FirebaseUser.swift
//  Invite
//
//  Created by User1 on 13.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUser {
    
    func setUserData(userData : UserProfile){
        
        let userArray = userData.convertToDictionary()
        let userId = userData.userId
        //запись в firebase по userId
        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(userArray)
        
        
    }
    func getUserData(userData : UserProfile )->UserProfile{
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let obs = AppDelegate.ref?.child("Users").observe(.value, with: { (snapshot) in
            
            for us in snapshot.children.allObjects as![DataSnapshot]{
                let usObj = us.value as?[String: String]
                
                let email = usObj?["email"]
                let name = usObj?["name"]
                let surname = usObj?["surname"]
                let aboutMe = usObj?["aboutMe"]
                let sex = usObj?["sex"]
                let sexFavorite = usObj?["sexFavorite"]
                let instagramUrl = usObj?["instagramUrl"]
                let age = usObj?["age"]
                //var foto = usObj?["foto"]
                
                if userData.email == email && us.key != ""{
                    
                    userData.userId = us.key
                    if aboutMe != nil { userData.aboutMe = aboutMe! } else{ userData.aboutMe = "" }
                    if name != nil {userData.name = name!}else{ userData.name = ""}
                    if surname != nil { userData.surname = surname!}else{ userData.surname = "" }
                    if sex != nil { userData.sex = sex!} else{ userData.sex = "" }
                    if sexFavorite != nil { userData.sexFavorite = sexFavorite!} else{ userData.sexFavorite = "" }
                    if age != nil { userData.age = age!} else{ userData.age = ""}
                    if instagramUrl != nil { userData.instagramUrl = instagramUrl!} else{ userData.instagramUrl = "" }
                    
                   // guard foto != nil else{ foto = "" } userData.foto = foto!
                }
            }
        })
        AppDelegate.ref?.removeObserver(withHandle: obs!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return userData
    }
    
    
}
//var userId: String
//var email : String
//// var phone : String
//var name : String
//var sex : String
//var sexFavorite : String
//var surname : String
//var age : String
//var instagramUrl : String
////   var foto : Data//10


