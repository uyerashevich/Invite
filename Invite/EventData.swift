//
//  EventData.swift
//  Invite
//
//  Created by User1 on 23.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import GoogleMaps

//struct
class  EventData : NSObject{
    
   
    
     var eventId: String?
  //  var usersId : [String]// approved Users
    var ownerUserId : String?
   // var eventName : String//eventId = ""
    var subTitle : String?
   var descriptionEvent : String?
    var date : String?
    var startTime : String?
    var endTime : String?
    var freeOrPaid : String?
    var amount : String?
    var everyone : String?
    var approvedUser : String?
    var contactPhone : String?
    var location: CLLocationCoordinate2D?
   // var eventImage : Data?
    
    
    override init (){
     //   usersId = [""]
        ownerUserId = ""
        eventId = ""
    //    eventName = ""eventId = ""
        subTitle = ""
      descriptionEvent = ""
        date = ""
        startTime = ""
        endTime = ""
        freeOrPaid = ""
        amount = ""
        everyone = ""
        approvedUser = ""
        contactPhone = ""
        location = nil
        
    }

    func convertToDictionary()-> [String: Any] {
        return["ownerUserId":ownerUserId , "eventId": self.eventId, "subTitle": self.subTitle, "descriptionEvent": self.descriptionEvent,"date": self.date, "startTime": self.startTime, "endTime": self.endTime, "freeOrPaid": self.freeOrPaid, "amount": self.amount  , "everyone": self.everyone, "approvedUser": self.approvedUser, "contactPhone": self.contactPhone]
        
    }
}
