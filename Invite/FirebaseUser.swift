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
    
    static let sharedInstance = FirebaseUser()
    
 
    private var ref: DatabaseReference? = Database.database().reference()
    private init(){}
    
    func updateUserData(userData : UserProfile){
        let userArray = userData.convertToDictionary()
        let userId = userData.userId
        ref?.child("/Users/").child(userId).updateChildValues(userArray)
    }
    
    func setSignInUserData(userData : UserProfile){
        var array = ["userId": userData.userId, "email" : userData.email, "socialName": userData.socialName]
        ref?.child("Users/").child(userData.userId).setValue(array, withCompletionBlock: { (error, request) in
            UserDefaults.standard.set( userData.userId, forKey: "userId")
        })
        //        //запись в firebase по userId
        //  ref?.child("/Users/").child(userId).updateChildValues(userArray)
    }
    
    
    ////альтернативный способ получ данных+++++!!!!! рабочий 100%
    //    func getUserDataById(userId : String, completionHandler: @escaping (UserProfile) -> Void){
    //        var userProfile = UserProfile
    //        let obs = ref?.child("Users").observe(.value, with: { (snapshot) in
    //
    //            for us in snapshot.children.allObjects as![DataSnapshot]{
    //                let usObj = us.value as?[String: Any]
    //
    //                let id = usObj?["userId"] as! String
    //
    //                if id == userId{
    //                    userProfile.userId = us.key
    //                    userProfile.email = usObj?["email"] as! String
    //                    userProfile.name = usObj?["name"]  as? String ?? ""
    //                    userProfile.surname = usObj?["surname"] as? String ?? ""
    //
    //                    userProfile.aboutMe = usObj?["aboutMe"] as? String ?? ""
    //                    userProfile.sex = usObj?["sex"] as? String ?? ""
    //                    userProfile.dateBirth = usObj?["dateBirth"] as? String ?? ""
    //                    userProfile.phone = usObj?["phone"] as? String ?? ""
    //
    //                  //  userProfile.favoriteEvent = usObj?["favoriteEvent"] ?? ""
    //                    userProfile.locationLat = usObj?["locationLat"] as? Double ?? 0
    //                    userProfile.locationLong = usObj?["locationLong"] as? Double ?? 0
    //
    //                    let foto = usObj?["foto"] as? String
    //                    if foto != nil { userProfile.foto = self.decodeImg(stringImage: foto!)}
    //                }
    //            }
    //            return completionHandler(userProfile)
    //        })
    //        //ref?.removeAllObservers()
    //        ref?.removeObserver(withHandle: obs!)
    //    }
    //
    
    func getUserDataById(userId : String, completionHandler: @escaping (UserProfile?, Error?) -> Void){
        let userProfile = UserProfile.init()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //  print("XXXXXRfxvdg\(userId)fhjENSA")
        //ref?.child("Users/\(userId)").observeSingleEvent(of: <#T##DataEventType#>, with: <#T##(DataSnapshot) -> Void#>)
        let obs = ref?.child("Users/\(userId)").observe(.childAdded, with: { (snapshot) in
            //    if snapshot == nil{print("XXXXXRENSA")}
            
            //   print("SNAPSHOT---\(snapshot)")
            let item = snapshot.key
            switch item{
            case "socialName" : do {userProfile.socialName = (snapshot.value as? String ?? "")}
            case "userId" : do {userProfile.userId = (snapshot.value as? String ?? "")}
            case "email" : do { userProfile.email = (snapshot.value as? String ?? "") }
            case "name" : do {userProfile.name = (snapshot.value as? String ?? "")}
            case "surname" : do { userProfile.surname = (snapshot.value as? String ?? "") }
                
            case "aboutMe" : do {userProfile.aboutMe = (snapshot.value as? String ?? "")}
            case "sex" : do { userProfile.sex = (snapshot.value as? String ?? "") }
            case "dateBirth" : do {userProfile.dateBirth = (snapshot.value as? String ?? "")}
            case "phone" : do { userProfile.phone = (snapshot.value as? String ?? "") }
                
//            case "locationLat" : do {userProfile.locationLat = (snapshot.value as? Double ?? 0)}
//            case "locationLong" : do {userProfile.locationLong = (snapshot.value as? Double ?? 0)}
                
                //case "favoriteEvent" : do {userProfile.favoriteEvent = (snapshot.value as? [String])}
                
                //            case "foto" : if let foto = snapshot.value as? [String] {
                //                for i in foto{
                //                    userProfile.foto?.append(self.decodeImg(stringImage: i)!)
                //                }
            //            }
            default : _ = 1
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            return completionHandler(userProfile, nil)
        })
        
        ref?.removeObserver(withHandle: obs!)
        
    }
    
    
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


//    func setUserData(userData : UserProfile){
//        var userArray = userData.convertToDictionary()
//        let userId = userData.userId
//        let email = userData.email
//        userArray["foto"] = codedImg(img: userData.foto)
//        //запись в firebase по userId
//        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(userArray)
//    }
//
//
//
//    //запись в firebase for google SignIN + facebook SignIn   !!!!!!!!!!!!!!!!!!!!!
//    func setUserData(userId: String, userEmail: String){
//        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(["email" : userEmail])
//    }
//
//
//
//    func getUserData(userData : UserProfile, completionHandler: @escaping (UserProfile) -> Void){
//        var userProfile = UserProfile.sharedInstance
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let obs = AppDelegate.ref?.child("Users").observe(.value, with: { (snapshot) in
//
//            for us in snapshot.children.allObjects as![DataSnapshot]{
//                let usObj = us.value as?[String: String]
//
//                let email = usObj?["email"] ?? ""
//
//             if userData.email == email && us.key != ""{
//                userProfile.userId = us.key
//                userProfile.name = usObj?["name"] ?? ""
//                userProfile.surname = usObj?["surname"] ?? ""
//                userProfile.aboutMe = usObj?["aboutMe"] ?? ""
//                userProfile.sex = usObj?["sex"] ?? ""
//                userProfile.sexFavorite = usObj?["sexFavorite"] ?? ""
//                userProfile.instagramUrl = usObj?["instagramUrl"]  ?? ""
//                userProfile.age = usObj?["age"] ?? ""
//               let foto = usObj?["foto"] as? String ?? ""
//
//
//                if foto != nil { userProfile.foto = self.decodeImg(stringImage: foto)!}
//                }
//
//            }
//            completionHandler(userProfile)
//        })
//        AppDelegate.ref?.removeObserver(withHandle: obs!)
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//
//    func getUserDataById(userId : String, completionHandler: @escaping (UserProfile) -> Void){
//        var userProfile = UserProfile.sharedInstance
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let obs = AppDelegate.ref?.child("Users").observe(.value, with: { (snapshot) in
//
//            for us in snapshot.children.allObjects as![DataSnapshot]{
//                let usObj = us.value as?[String: String]
//
//                let id = usObj?["userId"] ?? ""
//
//                if id == userId{
//                    userProfile.userId = us.key
//                    userProfile.name = usObj?["name"] ?? ""
//                    userProfile.surname = usObj?["surname"] ?? ""
//                    userProfile.aboutMe = usObj?["aboutMe"] ?? ""
//                    userProfile.sex = usObj?["sex"] ?? ""
//                    userProfile.sexFavorite = usObj?["sexFavorite"] ?? ""
//                    userProfile.instagramUrl = usObj?["instagramUrl"]  ?? ""
//                    userProfile.age = usObj?["age"] ?? ""
//                    let foto = usObj?["foto"] as? String ?? ""
//
//
//                    if foto != nil { userProfile.foto = self.decodeImg(stringImage: foto)!}
//                }
//
//            }
//         //   print("-----\(userProfile.name)")
//            completionHandler(userProfile)
//        })
//        AppDelegate.ref?.removeObserver(withHandle: obs!)
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//
//    // IMG -> String
//    private  func codedImg(img: UIImage)->String{
//        //сжатие картинки
//        guard let data = UIImageJPEGRepresentation(img,0.8) else {return ""}
//        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
//        return base64String
//    }
//    //String -> IMG
//    private func decodeImg(stringImage : String )->UIImage? {
//        if stringImage != "" {
//            guard let decodedData = Data(base64Encoded: stringImage, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
//                else {return  #imageLiteral(resourceName: "pixBlack") }
//            let decodedImage = UIImage(data: decodedData)
//            return decodedImage!
//        }else {return #imageLiteral(resourceName: "pixBlack")}
//    }
//
//}



