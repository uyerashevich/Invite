//
//  FiltersViewController.swift
//  Invite
//
//  Created by User1 on 29.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class FiltersViewController: BaseViewController {

    var eventData = EventData()
    var filterEvent =  [EventData]()
    
    @IBOutlet weak var nameEventTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var approvedSwitch: UISwitch!
    @IBOutlet weak var paidEventSwitch: UISwitch!
    @IBOutlet weak var privateEventSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         filterEvent = eventDataArray
       
    }

   
    @IBAction func tableVC(_ sender: UIButton) {
        self.performSegue(withIdentifier: "table", sender: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "table" {
        
//            let destinationVC = segue.destination as! TableViewController
//            destinationVC.eventDataArray = self.filterEvent
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        
       
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

   

}
