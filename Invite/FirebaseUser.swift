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
               
                
                if foto != nil { userProfile.foto = self.decodeImg(stringImage: foto)!}
                }
      
            }
            completionHandler(userProfile)
        })
        AppDelegate.ref?.removeObserver(withHandle: obs!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
  
    func getUserDataById(userId : String, completionHandler: @escaping (UserProfile) -> Void){
        var userProfile = UserProfile.sharedInstance
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let obs = AppDelegate.ref?.child("Users").observe(.value, with: { (snapshot) in

            for us in snapshot.children.allObjects as![DataSnapshot]{
                let usObj = us.value as?[String: String]

                let id = usObj?["userId"] ?? ""

                if id == userId{
                    userProfile.userId = us.key
                    userProfile.name = usObj?["name"] ?? ""
                    userProfile.surname = usObj?["surname"] ?? ""
                    userProfile.aboutMe = usObj?["aboutMe"] ?? ""
                    userProfile.sex = usObj?["sex"] ?? ""
                    userProfile.sexFavorite = usObj?["sexFavorite"] ?? ""
                    userProfile.instagramUrl = usObj?["instagramUrl"]  ?? ""
                    userProfile.age = usObj?["age"] ?? ""
                    let foto = usObj?["foto"] as? String ?? ""


                    if foto != nil { userProfile.foto = self.decodeImg(stringImage: foto)!}
                }

            }
         //   print("-----\(userProfile.name)")
            completionHandler(userProfile)
        })
        AppDelegate.ref?.removeObserver(withHandle: obs!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
//    func getUserDataById(userId : String, completionHandler: @escaping (UserProfile) -> Void){
//        var userProfile = UserProfile.sharedInstance
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let obs = AppDelegate.ref?.child("Users/\(userId)").observe(.childAdded, with: { (snapshot) in
//                let item = snapshot.key
//                switch item{
//                case "userId" : if let x = snapshot.value {userProfile.userId = x as! String ?? ""}
//                case "name" : if let x = snapshot.value {userProfile.name = x as! String ?? ""}
//                case "surname" : if let x = snapshot.value {userProfile.surname = x as! String ?? ""}
//
//                case "aboutMe" : if let x = snapshot.value {userProfile.aboutMe = x as! String ?? ""}
//                case "sex" : if let x = snapshot.value {userProfile.sex = x as! String ?? ""}
//                case "sexFavorite" : if let x = snapshot.value {userProfile.sexFavorite = x as! String ?? ""}
//
//                case "instagramUrl" : if let x = snapshot.value {userProfile.instagramUrl = x as! String ?? ""}
//                case "age" : if let x = snapshot.value {userProfile.age = x as! String ?? ""}
//                case "email" : if let x = snapshot.value {userProfile.email = x as! String ?? ""}
//
//                case "foto" : if let x = snapshot.value {
//                    let foto = x as! String ?? ""
//                    userProfile.foto = self.decodeImg(stringImage: foto)!
//                    }
//                default : _ = 1
//            }
//            print("---+++--\(userProfile.name)")
//            })
//        print("---+-++--\(userProfile.email)")
//        completionHandler(userProfile)
//
//        AppDelegate.ref?.removeObserver(withHandle: obs!)
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//
    // IMG -> String
    private  func codedImg(img: UIImage)->String{
        //сжатие картинки
        guard let data = UIImageJPEGRepresentation(img,0.8) else {return ""}
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        return base64String
    }
    //String -> IMG
    private func decodeImg(stringImage : String )->UIImage? {
        if stringImage != "" {
            guard let decodedData = Data(base64Encoded: stringImage, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                else {return  #imageLiteral(resourceName: "pixBlack") }
            let decodedImage = UIImage(data: decodedData)
            return decodedImage!
        }else {return #imageLiteral(resourceName: "pixBlack")}
    }
    
}



