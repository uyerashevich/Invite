//
//  Utils.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit

func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
    guard let url = URL(string: urlString) else {
        return closure(nil)
    }
    let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            print("error: \(String(describing: error))")
            return closure(nil)
        }
        guard response != nil else {
            print("no response")
            return closure(nil)
        }
        guard data != nil else {
            print("no data")
            return closure(nil)
        }
        DispatchQueue.main.async {
            closure(UIImage(data: data!))
        }
    }; task.resume()
}


func startActivityIndicator(viewController: UIViewController) {
    AppDelegate.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    AppDelegate.activityIndicator.center = viewController.view.center
    AppDelegate.activityIndicator.hidesWhenStopped = true
    AppDelegate.activityIndicator.activityIndicatorViewStyle = .whiteLarge
    viewController.view.addSubview(AppDelegate.activityIndicator)
    AppDelegate.activityIndicator.startAnimating()
}
func stopActivityIndicator() {
    AppDelegate.activityIndicator.stopAnimating()
    UIApplication.shared.endIgnoringInteractionEvents()
}
    
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





