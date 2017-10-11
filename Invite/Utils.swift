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

func isValidEmailAddress(emailAddressString: String) -> Bool {
    
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}
