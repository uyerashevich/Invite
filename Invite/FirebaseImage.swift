//
//  FirebaseImage.swift
//  Invite
//
//  Created by User1 on 21.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

struct FirebaseImage {
    
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            completion(metadata?.downloadURL())
        })
    }
}


import FirebaseDatabase
struct PostService {
    
    static func create(for image: UIImage, userId: String, nameImage: String, completion: @escaping (String?) -> Void){
        
        let imageRef = Storage.storage().reference().child("Users/\(userId)/fotoUser/\(nameImage).jpg")
        
        FirebaseImage.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return completion(nil)
            }
            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
            return completion(urlString)
        }
    }
    static func downloadsImageFirebase( userId: String, nameImage: String, completion: @escaping (UIImage?) -> Void){
        let imageRef = Storage.storage().reference().child("Users/\(userId)/fotoUser/\(nameImage).jpg")
      //  let imageRef = Storage.storage().reference(forURL: urlImage)
        imageRef.getData(maxSize: 1*1000*1000) { (data, error) in
            if error == nil{
                return completion(UIImage(data: data!))
            }else{ print(error)}
        }
    }
}

//let storage = Storage.storage()
//// Create a storage reference from our storage service
//let storageRef = storage.reference()
//let tempImageRef = storageRef.child("tmpDir/tmp.jpg")
////
//tempImageRef.getData(maxSize: 1*1000*1000) { (data, error) in
//    if error == nil{
//        self.photoUserImgView.image = UIImage(data: data!)
//    }else{ print(error)}
//}




//let dbRef = database.reference().child("myFiles")
//dbRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
//    // Get download URL from snapshot
//    let downloadURL = snapshot.value() as! String
//    // Create a storage reference from the URL
//    let storageRef = storage.referenceFromURL(downloadURL)
//    // Download the data, assuming a max size of 1MB (you can change this as necessary)
//    storageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
//        // Create a UIImage, add it to the array
//        let pic = UIImage(data: data)
//        picArray.append(pic)
//    })
//})

