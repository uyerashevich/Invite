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
    private init(){}

    private var listEvent = [EventData]()
    
    func getListEvent(completion: @escaping (_ result: [EventData])->()){
        if listEvent.count < 1  {
            print("OOOO---LLLLL")
            FirebaseEvent.init().getListEvent(completion: { (eventData) in
            self.listEvent.append(eventData)
        })}
        completion(listEvent)
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
