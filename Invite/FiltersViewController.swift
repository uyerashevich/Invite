//
//  FiltersViewController.swift
//  Invite
//
//  Created by User1 on 29.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    var eventDataArray = [EventData]()
    var eventData = EventData()
    var filterEvent =  [EventData]()
    
    @IBOutlet weak var nameEventTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var approvedSwitch: UISwitch!
    @IBOutlet weak var paidEventSwitch: UISwitch!
    @IBOutlet weak var privateEventSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         filterEvent = eventDataArray
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tableVC(_ sender: UIButton) {
        self.performSegue(withIdentifier: "table", sender: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "table" {
        
            let destinationVC = segue.destination as! TableViewController
            destinationVC.eventDataArray = self.filterEvent
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        
       
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
