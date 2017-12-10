//
//  EventsServices.swift
//  Invite
//
//  Created by User1 on 09.12.2017.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation

class EventsServices {
    
    static let sharedInstance = EventsServices()
    init(){}

    private var listEvent : [EventData] = []
    
    func getListEvent(completionHandler: @escaping ([EventData]) -> Void) {
        
        if listEvent.count < 1  {
            FirebaseEvent.init().getListEvent(completionHandler: { (eventData) in
                 self.listEvent.append(eventData)
            //    print("OOOO---service -\(eventData.eventName)")
                completionHandler(self.listEvent)
            })
        }
    }
    
    func getListEventCost(cost : Int, completion: @escaping (_ result: [EventData]?)->()){
        var sortList = [EventData]()
        getListEvent { ( listEvents ) in
            for i in listEvents {
                if i.cost < cost{
                    sortList.append(i)
                }
            }
           completion(sortList)
        }
    }
}
