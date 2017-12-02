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
        var userArray = userData.convertToDictionary()
        let userId = userData.userId
        let email = userData.email
        userArray["foto"] = codedImg(img: userData.foto)
        //запись в firebase по userId
        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(userArray)
    }
    
    //запись в firebase for google SignIN + facebook SignIn   !!!!!!!!!!!!!!!!!!!!!
    func setUserData(userId: String, userEmail: String){
        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(["email" : userEmail])
    }
    func getUserData(userData : UserProfile, completionHandler: @escaping (UserProfile) -> Void){
        var userProfile = UserProfile.sharedInstance
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let obs = AppDelegate.ref?.child("Users").observe(.value, with: { (snapshot) in
            
            for us in snapshot.children.allObjects as![DataSnapshot]{
                let usObj = us.value as?[String: String]
                
                let email = usObj?["email"] ?? ""
                
             if userData.email == email && us.key != ""{
                userProfile.userId = us.key
                userProfile.name = usObj?["name"] ?? ""
                userProfile.surname = usObj?["surname"] ?? ""
                userProfile.aboutMe = usObj?["aboutMe"] ?? ""
                userProfile.sex = usObj?["sex"] ?? ""
                userProfile.sexFavorite = usObj?["sexFavorite"] ?? ""
                userProfile.instagramUrl = usObj?["instagramUrl"]  ?? ""
                userProfile.age = usObj?["age"] ?? ""
               let foto = usObj?["foto"] as? String ?? ""
               
                
                if foto != nil { userProfile.foto = self.decodeImg(stringImage: foto)}
                }
      
            }
            completionHandler(userProfile)
        })
        AppDelegate.ref?.removeObserver(withHandle: obs!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
  
    
    // IMG -> String
    private  func codedImg(img: UIImage)->String{
        //сжатие картинки
        guard let data = UIImageJPEGRepresentation(img,0.8) else {return ""}
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        return base64String
    }
    //String -> IMG
    private func decodeImg(stringImage : String )->UIImage {
        if stringImage != "" {
            guard let decodedData = Data(base64Encoded: stringImage, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                else {return  #imageLiteral(resourceName: "emptyPixel") }
            let decodedImage = UIImage(data: decodedData)
            return decodedImage!
        }else {return #imageLiteral(resourceName: "emptyPixel")}
    }
    
}



