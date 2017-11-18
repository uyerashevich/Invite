//
//  GMapsUtils.swift
//  Invite
//
//  Created by User1 on 05.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

class GMapsUtils :NSObject, CLLocationManagerDelegate ,GMSMapViewDelegate{
    
    override init(){}
    
    func setMarker(coordinate: CLLocationCoordinate2D,title: String? ,image: UIImage?, googleMapsView: GMSMapView){
        let marker = GMSMarker(position: coordinate)
      
        let markerView : UIImageView?
       if  image != nil {
            markerView = UIImageView(image: image)
            marker.iconView = markerView
        }
            marker.title = title//"long:\(coordinate.longitude) lat:\(coordinate.latitude)"
            marker.map = googleMapsView
    }
    func delMarker(coordinate: CLLocationCoordinate2D,title: String? , googleMapsView: GMSMapView){
        let marker = GMSMarker(position: coordinate)
        marker.map = googleMapsView
            marker.map = nil
    }
}
    //цвет
    //marker.icon = GMSMarker.markerImage(with: .black)

//info window
//london.title = "London"
//london.snippet = "Population: 8,174,100"

//анимация+ свой Img
//    let house = UIImage(named: "House")!.withRenderingMode(.alwaysTemplate)
//    let markerView = UIImageView(image: house)
//    markerView.tintColor = .red
//    londonView = markerView
//
//    let position = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.127)
//    let marker = GMSMarker(position: position)
//    marker.title = "London"
//    marker.iconView = markerView
//    marker.tracksViewChanges = true
//    marker.map = mapView
//    london = marker
//}
//
//func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//    UIView.animate(withDuration: 5.0, animations: { () -> Void in
//        self.londonView?.tintColor = .blue
//    }, completion: {(finished) in
//        // Stop tracking view changes to allow CPU to idle.
//        self.london?.tracksViewChanges = false
//    })
//}

//marker.opacity = 0.6   //Прозрачность маркера можно анимировать GMSMarkerLayer


