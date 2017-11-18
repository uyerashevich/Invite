//
//  EventListViewController.swift
//  Invite
//
//  Created by User1 on 18.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class EventListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
//    var eventDataArray = [EventData]()
    
 // @IBOutlet weak var tableView: UITableView!
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       print("\(EventList.sharedInstance.eventList.count)----list--eventDataArray.count")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return EventList.sharedInstance.eventList.count
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath ) as! EventListCollectionViewCell
        
       // print(EventList.sharedInstance.eventList[indexPath.row].eventId)
                cell.nameEventLabel.text =  EventList.sharedInstance.eventList[indexPath.row].eventId
                cell.placeEventLabel.text = EventList.sharedInstance.eventList[indexPath.row].address
                cell.distanceLabel.text = "0km"
                cell.costEventLabel.text = EventList.sharedInstance.eventList[indexPath.row].cost
                cell.fotoEventImgView.image = EventList.sharedInstance.eventList[indexPath.row].eventImage
        return cell
     }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return  EventList.sharedInstance.eventList.count
//    }
//
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventListTableViewCell
//        print(EventList.sharedInstance.eventList[indexPath.row].eventId)
//        cell.nameEventLabel.text = EventList.sharedInstance.eventList[indexPath.row].eventId
//        cell.placeEventLabel.text = EventList.sharedInstance.eventList[indexPath.row].address
//        cell.distanceLabel.text = "10"
//        cell.costEventLabel.text = EventList.sharedInstance.eventList[indexPath.row].amount
//      //  cell.fotoEventImgView.image = EventList.sharedInstance.eventList[indexPath.row].eventImage
//
//        return cell
//
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
//    }

}
