//
//  EventListCollectionViewCell.swift
//  Invite
//
//  Created by User1 on 18.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class EventListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var costEventLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameEventLabel: UILabel!
    @IBOutlet weak var fotoEventImgView: UIImageView!
    @IBOutlet weak var placeEventLabel: UILabel!
    
    
    var event: EventData! {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        
             distanceLabel.text = "\(10) mi"
        
        nameEventLabel.text = event.eventName
        placeEventLabel.text = event.address
       
        var greenColor = UIColor(red: 147.0/255.0, green: 211.0/255.0, blue: 33.0/255.0, alpha: 1.0) //38C3F7
        var blueColor = UIColor(red: 56.0/255.0, green: 195.0/255.0, blue: 247.0/255.0, alpha: 1.0) //38C3F7
        
        if event.cost != 0{
            costEventLabel.textColor = blueColor
            costEventLabel.text = "$\(event.cost)"
        }else{
            costEventLabel.textColor = greenColor
            costEventLabel.text = "Free"
        }
        fotoEventImgView.image = event.eventImage
        
    }
}
