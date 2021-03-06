//
//  FirebaseEvent.swift
//  Invite
//
//  Created by User1 on 23.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import Firebase

class FirebaseEvent{
    
    func setEventData(eventData : EventData){
        
        let eventName = eventData.eventName
        let ownUserId = eventData.ownerUserId
        
        var eventDict = eventData.convertToDictionary()
        eventDict["eventId"] = "\(eventName)\(ownUserId)"
        eventDict["eventImage"] = codedImg(img: eventData.eventImage )
        //запись в firebase по eventId
        AppDelegate.ref?.child("/Event/ListEvents/\(eventName)\(ownUserId)").updateChildValues(eventDict)
    }
  
   func getListEvent(completionHandler: @escaping (EventData) -> Void){
        var  evData = EventData()
        
        let obs = AppDelegate.ref?.child("Event/ListEvents/").observe(.childAdded, with: { (snapshot) in
            //print(snapshot)
            for us in (snapshot.children.allObjects as![DataSnapshot]){
                
                evData.eventId = snapshot.key
                var value = snapshot.value as? [String: Any]//NSDictionary
                evData.eventName = value?["eventName"] as? String ?? ""
                evData.ownerUserId = value?["ownerUserId"] as? String ?? ""
                evData.subTitle = value?["subTitle"] as? String ?? ""
                evData.descriptionEvent = value?["descriptionEvent"] as? String ?? ""
                evData.date = value?["date"] as? String ?? ""
                evData.startTime = value?["startTime"] as? String ?? ""
                evData.endTime = value?["endTime"] as? String ?? ""
                evData.approvedUser = value?["approvedUser"] as? String ?? ""
                evData.cost = value?["cost"] as? Int ?? 0
                evData.everyone = value?["everyone"] as? String ?? ""
                evData.contactPhone = value?["contactPhone"] as? String ?? ""
                evData.address = value?["address"] as? String ?? ""
                
                evData.locationLat = value?["locationLat"] as? Double ?? 0
                evData.locationLong = value?["locationLong"] as? Double ?? 0
                
                if let foto = value?["eventImage"]{ evData.eventImage = self.decodeImg(stringImage: foto as! String)}
            }
              //  print(evData.eventName)
                completionHandler(evData)
        })
        AppDelegate.ref?.removeObserver(withHandle: obs!)
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





