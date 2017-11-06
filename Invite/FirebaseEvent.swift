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
        
        let eventDict = eventData.convertToDictionary()
        let eventId = eventData.eventId
        let ownUserId = eventData.ownerUserId
        //запись в firebase по eventId
        AppDelegate.ref?.child("/Event/\(ownUserId)/").child(eventId!).updateChildValues(eventDict)
        
        
    }
    func getEventData(eventData : EventData, completion: @escaping (_ result: EventData)->()){
       var  evData = EventData()
        let z = eventData.ownerUserId
        
        
        
        let obs = AppDelegate.ref?.child("Event/" + z!).observe(.childAdded, with: { (snapshot) in
//print(snapshot)
            for us in (snapshot.children.allObjects as![DataSnapshot]){
                
                evData.eventId = snapshot.key
                var value = snapshot.value as? [String: Any]//NSDictionary
                
                evData.ownerUserId = value?["ownerUserId"] as? String ?? ""
                evData.subTitle = value?["subTitle"] as? String ?? ""
                evData.descriptionEvent = value?["descriptionEvent"] as? String ?? ""
                evData.date = value?["date"] as? String ?? ""
                evData.startTime = value?["startTime"] as? String ?? ""
                evData.endTime = value?["endTime"] as? String ?? ""
                evData.approvedUser = value?["approvedUser"] as? String ?? ""
                evData.freeOrPaid = value?["freeOrPaid"] as? String ?? ""
                evData.everyone = value?["everyone"] as? String ?? ""
                evData.contactPhone = value?["contactPhone"] as? String ?? ""
                evData.amount = value?["amount"] as? String ?? ""
                
            }
           
           // eventDataArray.append(evData)
         
           
          //  print(eventDataArray[eventDataArray.count - 1].subTitle)
           completion(evData)
        })
        { (error) in
            print(error.localizedDescription)
        }
//       print(eventDataArray.count)
//        print(eventDataArray[0].subTitle)
//print(eventDataArray[1].subTitle)
// print(eventDataArray[2].subTitle)
    }
}




