//
//  Utils.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit




func startActivityIndicator(viewController: UIViewController) {
    AppDelegate.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    AppDelegate.activityIndicator.center = viewController.view.center
    AppDelegate.activityIndicator.hidesWhenStopped = true
    AppDelegate.activityIndicator.activityIndicatorViewStyle = .gray
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
func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
    
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}



// IMG -> String
func codedImg(img: UIImage)->String{
    
    guard let image = resizeImage(image: img , newWidth: 400) else { return ""}
    
    
    //сжатие картинки
    guard let data = UIImageJPEGRepresentation(image,0.8) else {return ""}
    
    let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    return base64String
}
//String -> IMG
func decodeImg(stringImage : String )->UIImage {
    
    if stringImage != "" {
        guard let decodedData = Data(base64Encoded: stringImage, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            else {return  #imageLiteral(resourceName: "emptyPixel") }//logo
        
        let decodedImage = UIImage(data: decodedData)
        return decodedImage!
        
    }else {return #imageLiteral(resourceName: "emptyPixel")}
}
