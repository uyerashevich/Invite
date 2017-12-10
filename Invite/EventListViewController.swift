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

    var eventList : [EventData] = [] {
        didSet{
            print("33333----\(self.eventList.count)----list--eventDataArray.count")
            if tableView != nil{ tableView.reloadData()}
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
                EventsServices.sharedInstance.getListEvent ( completionHandler: { (evList) in
                    self.eventList = evList
                })

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
    //определяет какую ячейку выбрали и производит дальнейшие действия
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
//   func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
//
//
//        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
//            print("favorite button tapped")
//        }
//        //favorite.provideImageData(<#T##data: UnsafeMutableRawPointer##UnsafeMutableRawPointer#>, bytesPerRow: <#T##Int#>, origin: <#T##Int#>, <#T##y: Int##Int#>, size: <#T##Int#>, <#T##height: Int##Int#>, userInfo: <#T##Any?#>)
//        favorite.backgroundColor = .black
//
////        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
////            print("share button tapped")
////        }
////        share.backgroundColor = .blue
//
//        //return [share, favorite, more]
//        return [favorite]
//    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action

            // Reset state
            success(true)
        })
        favoriteAction.image = #imageLiteral(resourceName: "star_enabled")//UIImage(named: "ic_delete")
        favoriteAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}
//public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?

