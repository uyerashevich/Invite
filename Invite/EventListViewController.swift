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
  
    var eventList = [EventData]() {
        didSet{
             print("\(eventList.count)----list--eventDataArray.count")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return  eventList.count
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath ) as! EventListCollectionViewCell
            let event = eventList[indexPath.row]
            cell.event = event
            return cell
     }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
  
}
