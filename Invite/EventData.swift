//
//  EventData.swift
//  Invite
//
//  Created by User1 on 23.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import GoogleMaps
class EventList: NSObject{
    
    static let sharedInstance = EventList()
    
 //   private override init(){}
    
    var eventList = [EventData]()  
}

struct  EventData {
    
   
    var ownerUserId : String
     var eventId: String
  var address : String
    
    var subTitle : String?
   var descriptionEvent : String?
    var date : String?
    
    var startTime : String
    var endTime : String?
    var cost : String
    
    var amount : String?
    var everyone : String?
    var approvedUser : String?
    
    var contactPhone : String?
    var locationLat: Double?
    var locationLong: Double?
    var eventImage : UIImage
    
    
  init (){
   
        ownerUserId = ""
        eventId = ""
        address = ""
   
        subTitle = ""
      descriptionEvent = ""
        date = ""
        
        startTime = ""
        endTime = ""
        cost = ""
        
     
        everyone = ""
        approvedUser = ""
        contactPhone = ""
    
        locationLat = 0
        locationLong = 0
        eventImage = #imageLiteral(resourceName: "button")
    }

    func convertToDictionary()-> [String: Any] {
        return["ownerUserId":ownerUserId,
               "eventId": self.eventId,
                "address": self.address,
                
               "subTitle": self.subTitle,
               "descriptionEvent": self.descriptionEvent,
               "date": self.date,
               
               "startTime": self.startTime,
               "endTime": self.endTime,
               "cost": self.cost,
              
               "everyone": self.everyone,
               "approvedUser": self.approvedUser,
               "contactPhone": self.contactPhone,
        
               "locationLat": self.locationLat,
               "locationLong": self.locationLong ]
        
    }
}
