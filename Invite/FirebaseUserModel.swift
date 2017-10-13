//
//  FirebaseUserModel.swift
//  Invite
//
//  Created by User1 on 13.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUserModel {
 
    func setUserData(userData : UserProfile){
        
        let userArray = userData.convertToDictionary()
        let userId = userData.userId
        //запись в firebase по userId
        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(userArray)
        

    }
    
    //запись в firebase for google SignIN + facebook SignIn   !!!!!!!!!!!!!!!!!!!!!
//    func setUserData(userData : UserProfile){
//        let userArray = userData.convertToDictionary()
//        let userId = userData.userId
//        //запись в firebase по userId
//        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(["userEmail" : userEmail])
//        UserDefD.init().saveUserDataUD(userId: userId, userEmail: userEmail, profession: "", placeOfWork: "", phone: "", name: "", surname: "", yearB: "")
//    }
    
//    func setUserImage(userId : String, img : UIImage) {
//        
//        let imgString = codedImg(img: img)// конвертер img ->string
//        
//        AppDelegate.ref?.child("/Users/").child(userId).updateChildValues(["img" : imgString ])//дозапись в firebase по userId и key
//        UserDefD.init().saveUserImgUD(img: imgString)
//        
//    }
    
    //чтение из firebase+ сортировка по переменным  +++++++++++++
//    func readUserData(email: String){
//        
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        
//        let obs = AppDelegate.ref?.child("Users").observe(.value, with: { (snapshot) in
//            
//            for us in snapshot.children.allObjects as![FIRDataSnapshot]{
//                let usObj = us.value as?[String: String]
//                
//                let userEmail = usObj?["userEmail"]
//                var name = usObj?["name"]
//                var surname = usObj?["surname"]
//                var phone = usObj?["phone"]
//                var profession = usObj?["profession"]
//                var placeOfWork = usObj?["placeOfWork"]
//                var img = usObj?["img"]
//                var yearB = usObj?["yearB"]
//                
//                
//                if email == userEmail && us.key != ""{//String(describing: userEmail)
//                    
//                    let userId = us.key
//                    if (name == nil) { name = "" }
//                    if (surname == nil) { surname = "" }
//                    if (phone == nil) { phone = "" }
//                    if (profession == nil) { profession = "" }
//                    if (placeOfWork == nil) { placeOfWork = ""}
//                    if (img == nil) { img = "" }
//                    if (yearB == nil) { yearB = "" }
//                    
//                    //!!!!!! поток с низким приоритетом и задерж 2 сек
//                    //                   let queueLow = DispatchQueue(label: "com.serialPriority2", qos: .utility)
//                    //                    queueLow.asyncAfter(deadline: .now() + 2) {
//                    
//                    UserDefD.init().saveUserDataUD(userId: userId, userEmail: userEmail!, profession: profession!, placeOfWork: placeOfWork!, phone: phone!, name: name!, surname: surname!, yearB: yearB!)
//                    
//                    
//                    // img save in udefault
//                    UserDefD.init().saveUserImgUD(img: img! )
//                }
//            }
//        })
//        AppDelegate.ref?.removeObserver(withHandle: obs!)
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
}
