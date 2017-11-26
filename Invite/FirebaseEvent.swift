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
        
        var eventDict = eventData.convertToDictionary()
        let eventId = eventData.eventId
        let ownUserId = eventData.ownerUserId
        
       
        eventDict["eventImage"] = codedImg(img: eventData.eventImage )
        //запись в firebase по eventId
        AppDelegate.ref?.child("/Event/\(ownUserId)/").child(eventId).updateChildValues(eventDict)
    }
    
    
    func getEventData(eventData : EventData, completion: @escaping (_ result: EventData)->()){
        var  evData = EventData()
        let z = "/\(eventData.ownerUserId)"
        
        
        
        let obs = AppDelegate.ref?.child("Event" + z).observe(.childAdded, with: { (snapshot) in
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
                evData.cost = value?["cost"] as? String ?? ""
                evData.everyone = value?["everyone"] as? String ?? ""
                evData.contactPhone = value?["contactPhone"] as? String ?? ""
                evData.address = value?["address"] as? String ?? ""

                evData.locationLat = value?["locationLat"] as? Double ?? 0
                evData.locationLong = value?["locationLong"] as? Double ?? 0
                
                if let foto = value?["eventImage"]{ evData.eventImage = self.decodeImg(stringImage: foto as! String)}
            }
            print(evData.locationLong)
            


           completion(evData)
        })
        { (error) in
            print(error.localizedDescription)
        }
        AppDelegate.ref?.removeObserver(withHandle: obs!)
    }
    
    
    func getAllEvent( completion: @escaping (_ result: [EventData])->()){
        var event = EventData()
        var  evData : [EventData] = []
        
       // AppDelegate.ref?.child("Event/").
        let obs = AppDelegate.ref?.child("Event/").observe(.value, with: { (snapshot) in
            for us in snapshot.children.allObjects {
//                //print(us)
//                var valu = us
//                print("\(valu as![DataSnapshot] )-=-==---=-=-=")
              
                
                //let ownerUserId = usObj?[ String]
            //    print(ownerUserId)
//                let subTitle = usObj?["subTitle"]
//                let descriptionEvent = usObj?["descriptionEvent"]
//                let date = usObj?["date"]
//                let startTime = usObj?["startTime"]
//                let endTime = usObj?["endTime"]
//                let approvedUser = usObj?["approvedUser"]
//                let freeOrPaid = usObj?["freeOrPaid"]
//
//                let everyone = usObj?["everyone"]
//                let contactPhone = usObj?["contactPhone"]
//                let amount = usObj?["amount"]
            }
//                    if ownerUserId != nil { event.ownerUserId = ownerUserId! } else{ event.ownerUserId  = "" }
//                    if subTitle != nil {event.subTitle = subTitle!}else{ event.subTitle = ""}
//                    if descriptionEvent != nil { event.descriptionEvent = descriptionEvent!}else{ event.descriptionEvent = "" }
//                    if date != nil { event.date = date!} else{ event.date = "" }
//                    if startTime != nil { event.startTime = startTime!} else{ event.startTime = "" }
//                    if endTime != nil { event.endTime = endTime!} else{ event.endTime = ""}
//                    if approvedUser != nil { event.approvedUser = approvedUser!} else{ event.approvedUser = "" }
//                if freeOrPaid != nil { event.freeOrPaid = freeOrPaid!} else{ event.freeOrPaid = "" }
//
//                if everyone != nil { event.everyone = everyone!} else{ event.everyone = "" }
//                if contactPhone != nil { event.contactPhone = contactPhone!} else{ event.contactPhone = ""}
//                if amount != nil { event.amount = amount!} else{ event.amount = "" }
     //      }
        

        })
        print(event.eventId)
        evData.append(event)
        print(evData.count)
         print("\(evData.count)----\(evData[0].eventId)")
        completion(evData)
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





