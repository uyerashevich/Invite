//
//  Utils.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit


func facebookSignIn(view: UIViewController){
AppDelegate.checkerFG = 1

let facebookLogin = FBSDKLoginManager()

facebookLogin.logIn(withReadPermissions: ["email"], from: view) { (facebookResult, facebookError) in
    if facebookError != nil {
        
        displayAlertMessage(messageToDisplay: "There was an error logging in to Facebook. Error: \(facebookError)", viewController: view)
    } else
        if (facebookResult?.isCancelled)!
        {
            print("Facebook login was cancelled!")
        }
        else {
            
            let credential = (FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString))
            
            //signin in Firebase
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                print("user signed into firebase")
                
                if user != nil{
                    print (user?.email)
                    
                    view.performSegue(withIdentifier: "goToPaty", sender: view)
                    
                    
                }else{
                    //error: check error and show message
                    displayAlertMessage(messageToDisplay: "Проверьте подключение к интернету ", viewController: view )
                }
            })
    }
}
}


func signInUser(userEmail : String, userPassword : String, view: UIViewController){
    
    //signin in Firebase.google.com
    Auth.auth().signIn(withEmail:  userEmail, password: userPassword, completion: { (user, error) in
        if user != nil {
            view.performSegue(withIdentifier: "goToPaty", sender: view)
        }
        else{
            //error: check error and show message
            displayAlertMessage(messageToDisplay: "Verify you pass or login ", viewController: view )
            return
        }
    })
}


func signUpUser (userEmail : String, userPassword : String, reUserPassword: String, view: UIViewController){
    
    //valid pass
    guard (userPassword == reUserPassword) else{
        displayAlertMessage(messageToDisplay: "Enter the password again",viewController: view)
        return
    }
    
    //regisration in Firebase Firabase.google.com
    Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion:  { (user, error) in
        //check that user not nil
        if (user != nil) {
            
            
//            self.loginTextField.text = ""
//            self.passwordTextField.text = ""
//            self.rePasswordTextField.text = ""
            
            view.performSegue(withIdentifier: "goToPaty", sender: view)
            
        }
        else {
            //error: check error and show mess
            displayAlertMessage(messageToDisplay: "This user already exists" , viewController: view)
        }
    })
}

func validLoginPassword(userEmail: String,userPassword :String )->Bool{
    
    //valid email
    let finalEmail = userEmail.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let isEmailAddresValid = isValidEmailAddress(emailAddressString: finalEmail)
    guard isEmailAddresValid else{
       // displayAlertMessage(messageToDisplay: "Email addres is not valid",viewController: self)
        return false
    }
    // valid on >6 char in pass for Firebase
    guard (userPassword.characters.count) > 5 else{
      //  displayAlertMessage(messageToDisplay: "Password must be longer than 6 characters", viewController: self)
        return false
    }
    return true
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
