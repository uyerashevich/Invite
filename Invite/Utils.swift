//
//  Utils.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit

func displayAlertMessage(messageToDisplay: String, viewController: UIViewController){
    let alertController = UIAlertController(title: "", message: messageToDisplay, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
    }
    alertController.addAction(OKAction)
    viewController.present(alertController, animated: true, completion:nil)
}
