//
//  EventListViewController.swift
//  Invite
//
//  Created by User1 on 18.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class EventListViewController : BaseViewController,UITableViewDelegate , UITableViewDataSource {
    
 
  
    @IBOutlet weak var tableView: UITableView!
    
//    var userVC : UserViewController?
    
    var eventList : [EventData] = [] {
        didSet{
            print("33333----\(self.eventList.count)----list--eventDataArray.count")
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("444----\(eventList.count)----list--eventDataArray.count")
        return eventList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListEventsTableViewCell
        let event = eventList[indexPath.row]
                    cell.event = event
                    return cell
    }
    //определяет какую ячейку выбрали и производит дальнейшие действия - заполняет промежуточный диагноз и переходит на следующий экран подумать может сделать шторку на этом????
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if filtered.count > 0 {
//            nameOfPD = filtered[indexPath.row]
//        }else{
//            nameOfPD = array[indexPath.row]
//        }
//        //переход с кнопкой
//        performSegue(withIdentifier: "viewFullDDin", sender: "")
    }
    


}
