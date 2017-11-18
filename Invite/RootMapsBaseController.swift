//
//  RootMapsController.swift
//  GardenMarket
//
//  Created by User1 on 15.11.17.
//  Copyright © 2017 GardenMedia. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

class RootMapsBaseController :  UIViewController, CLLocationManagerDelegate ,GMSMapViewDelegate {
    
    var googleMapsView: GMSMapView!
    var locationManager = CLLocationManager()
    var myLatitude : CLLocationDegrees?
    var myLongitude : CLLocationDegrees?
    var camera : GMSCameraPosition?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleMapsView?.delegate = self
        locationManager.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
   
     //   dataForUI()
    }
    
//    func dataForUI(){
//
//    }
//    //locationManager(_:didChangeAuthorizationStatus:) вызывается, когда пользователь предоставляет или не предоставляет вам право определения его местоположение
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            //        //GMSMapView . myLocationEnabled рисует голубую точку в том месте, где находится пользователь, myLocationButton, при значении true, добавляет кнопку на карту, которая при прикосновении к экрану, центрирует карту на месте пользователя
//            googleMapsView?.isMyLocationEnabled = true
//            googleMapsView?.settings.myLocationButton = true
//        }
//    }
    override func loadView() {
        if let latitude = locationManager.location?.coordinate.latitude { myLatitude = latitude }
        if let longitude = locationManager.location?.coordinate.longitude {myLongitude = longitude}
        camera = GMSCameraPosition.camera(withLatitude: myLatitude!, longitude: myLongitude!, zoom: 10)
        googleMapsView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        view = googleMapsView
    }
    
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//
//       // GMapsUtils.init().setMarker(coordinate: coordinate, title: "", googleMapsView: self.googleMapsView)
//        //сделать запись координат в adverts
//    }
}

