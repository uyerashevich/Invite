//
//  MapBaseViewController.swift
//  Invite
//
//  Created by User1 on 05.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapBaseViewController : RootMapsBaseController {
   
    var eventDataArray = [EventData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
             dataForUI()
      //  print(AppDelegate.eventDataArray.count)
    }

    
   func dataForUI(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //53.876279, 27.536647 minsk
        myLatitude = 53.876279
        myLongitude = 27.536647
        googleMapsView?.isMyLocationEnabled = true
        googleMapsView?.settings.myLocationButton = true
//
//                GMapsUtils.init().setMarker(coordinate: coordinateEvent, title: "\(j)", image: "", googleMapsView: self.googleMapsView)
        
   }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        print("-------000000--------")
//        for i in self.eventArray{
//            if i.event.lat == marker.position.latitude || i.event.lng == marker.position.longitude {
//                idAdvert = i.id
//                print(i.id)
//            }
//        }
        return true
    }
}
