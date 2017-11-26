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

class MapBaseViewController : UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
   

   
    
        var locationManager = CLLocationManager()
        var myLatitude : CLLocationDegrees?
        var myLongitude : CLLocationDegrees?
        var camera : GMSCameraPosition?
    
      // var nameSenderVC : String?

        @IBOutlet weak var mapView: GMSMapView!
    
        
//        var eventSortArray: [EventData] = [] {
//            didSet {
//                eventInfoVC.markerSortArray = self.markerSortArray
//            }
//        }
//        var eventsArray: [EventData] = []{
//            didSet{
//                viewDidAppear(true)
//            }
//        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            mapView?.delegate = self
            
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            managerMaps()
        }
        func managerMaps(){
//            if nameSenderVC == "  -------    "{
//                if eventsArray[0].locationLat != nil {
//                    let coordinateEvent = CLLocationCoordinate2D(latitude: (eventsArray[0].locationLat)!, longitude: (eventsArray[0].locationLong)!)
//                    setMarker(coordinate: coordinateEvent, title: nil, image: nil)
//                    setCamera(withLatitude: coordinateEvent.latitude, longitude: coordinateEvent.longitude,zoom: 13)
//                }
//            }else{
              myLocation()
//            }
        }
        func myLocation(){
            mapView?.isMyLocationEnabled = true
            mapView?.settings.myLocationButton = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            myLatitude = 37.376967
            myLongitude = -3.115037
            if let latitude = locationManager.location?.coordinate.latitude { myLatitude = latitude }
            if let longitude = locationManager.location?.coordinate.longitude {myLongitude = longitude}
        }
        
        func setCamera(withLatitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom : Float){
            camera = GMSCameraPosition.camera(withLatitude: withLatitude, longitude: longitude, zoom: zoom)
            mapView.camera = camera!
        }
        
        func setArrayMarkers(){
            mapView.clear()
            
//            for i in self.eventsArray{
//                if i.lat != nil {
//                    let  coordinateAdverts = CLLocationCoordinate2D(latitude: ()!, longitude: ()!)
//
//                        setMarker(coordinate: coordinateAdverts, title: nil,image: #imageLiteral(resourceName: ""))

//                }
//            }
        }
    
        
        func setMarker(coordinate: CLLocationCoordinate2D,title: String? ,image: UIImage?){
            let marker = GMSMarker(position: coordinate)
            
            let markerView : UIImageView?
            if  image != nil {
                markerView = UIImageView(image: image)
                marker.iconView = markerView
            }
            marker.title = title
            marker.map = mapView
        }
    
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            var xArray = [EventData]()
     
//поиск маркера тапа
            return true
        }
 
    
        
    
}









//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//             dataForUI()
//      //  print(AppDelegate.eventDataArray.count)
//    }
//
//
//   func dataForUI(){
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        //53.876279, 27.536647 minsk
//        myLatitude = 53.876279
//        myLongitude = 27.536647
//        googleMapsView?.isMyLocationEnabled = true
//        googleMapsView?.settings.myLocationButton = true
////
////                GMapsUtils.init().setMarker(coordinate: coordinateEvent, title: "\(j)", image: "", googleMapsView: self.googleMapsView)
//
//   }
//
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
////        print("-------000000--------")
////        for i in self.eventArray{
////            if i.event.lat == marker.position.latitude || i.event.lng == marker.position.longitude {
////                idAdvert = i.id
////                print(i.id)
////            }
////        }
//        return true
//    }
//}

