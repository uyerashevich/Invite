//
//  GPlacesViewController.swift
//  Invite
//
//  Created by User1 on 05.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import GooglePlacePicker

class GPlacesViewController: UIViewController , UISearchBarDelegate , LocateOnTheMap , GMSAutocompleteFetcherDelegate , CLLocationManagerDelegate ,GMSMapViewDelegate {
    
    @IBOutlet weak var navigationBarBottom: UINavigationItem!
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
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
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
    
    //locationManager(_:didChangeAuthorizationStatus:) вызывается, когда пользователь предоставляет или не предоставляет вам право определения его местоположение
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            //        //GMSMapView . myLocationEnabled рисует голубую точку в том месте, где находится пользователь, myLocationButton, при значении true, добавляет кнопку на карту, которая при прикосновении к экрану, центрирует карту на месте пользователя
            googleMapsView?.isMyLocationEnabled = true
            googleMapsView?.settings.myLocationButton = true
        }
    }
//    /////////////////////////////
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            googleMapsView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
//            locationManager.stopUpdatingLocation()
//            fetchNearbyPlaces(location.coordinate)
//        }
//    }
//    func fetchNearbyPlaces(_ coordinate: CLLocationCoordinate2D) {
//        //        mapView?.clear()
//        //        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
//        //            for place: GooglePlace in places {
//        //                let marker = PlaceMarker(place: place)
//        //                marker.map = self.mapView
//        //            }
//        //        }
//    }
//    // рвсщифровка адреса из координат
//    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
//        let geocoder = GMSGeocoder()
//        //Просим геокодер изменить геокодирование координат, переданных методу. Затем проверяем, есть ли адрес в ответ типа GMSAddress. Это модель класса для адресов, возвращенных GMSGeocoder
//        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
//            if let address = response?.firstResult() {
//                let lines = address.lines
//                print(address.description)
//                self.navigationBarBottom.title = lines?.joined(separator: "\n")
//            }else{print("error GMSAddress ")}
//        }
//    }
    //  Отслеживание событий нажатия достопримечательностей
    override func loadView() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
                if let latitude = locationManager.location?.coordinate.latitude { myLatitude = latitude }
                if let longitude = locationManager.location?.coordinate.longitude {myLongitude = longitude}
       
        
                camera = GMSCameraPosition.camera(withLatitude: myLatitude!, longitude: myLongitude!, zoom: 10)
                googleMapsView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
                view = googleMapsView
    }
    func setMarker(coordinate: CLLocationCoordinate2D,title: String?){
        let marker = GMSMarker(position: coordinate)
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 10)
        self.googleMapsView.camera = camera
        
        if title != nil{
            marker.title = "long:\(coordinate.longitude) lat:\(coordinate.latitude)"
            marker.map = self.googleMapsView
        }
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        setMarker(coordinate: coordinate, title: "event")
    }
    
    @IBAction func searchWithAdress(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated:true, completion: nil)
    }
    
    //  Locate map with longitude and longitude after search location on UISearchBar
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async { () -> Void in
            let position = CLLocationCoordinate2DMake(lat, lon)
            self.setMarker(coordinate: position, title: nil)
        }
    }
    // Searchbar when text change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
            print("Error @%",Error.self)
            self.resultsArray.removeAll()
            if results == nil { return }
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            self.searchResultController.reloadDataWithArray(self.resultsArray)
        }
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
    }
    public func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    //   Called when autocomplete predictions are available.
    //  param predictions an array of GMSAutocompletePrediction objects.
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        for prediction in predictions {
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        
       
    }
} 
