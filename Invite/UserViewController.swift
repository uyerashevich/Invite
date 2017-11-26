//
//  UserViewController.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
//import FBSDKLoginKit

class UserViewController: BaseViewController, UITextFieldDelegate{ //
    
    
    
    @IBOutlet weak var ageButtonOutlet: UIButton!
    @IBOutlet weak var sexFavoriteButtonOutlet: UIButton!
    @IBOutlet weak var sexButtonOutlet: UIButton!
    
    
    
    @IBOutlet weak var imgUserMaskView: UIView!
    @IBOutlet weak var photoUserImgView: UIImageView!
    
    @IBOutlet weak var instagrammTexField: UITextField!
    
    @IBOutlet weak var surnameTexField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    let imagePick = ImagePickerActionSheet.init()
    var typePicker : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //firebase EVENT
        //        FirebaseEvent.init().getAllEvent { (arrayEvent) in
        //            self.eventDataArray = arrayEvent
        //   // print("\(self.eventDataArray.count)----\( self.eventDataArray[0].eventId)")
        //        }
        
        
        self.dataForUi()
    }
    
    //для убирания клавы с экрана/////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dataForUi(){
        
        nameTextField.text = userProfile.name
        surnameTexField.text = userProfile.surname
        
        instagrammTexField.text = userProfile.instagramUrl
        photoUserImgView.image = userProfile.foto
        
    }
    @IBAction func tapImage(_ sender: Any) {
        imagePick.showCameraLibrary(view: self)
        imagePick.onDataUpdate = { [weak self] (image: UIImage) in
            let resizeImage = image.fixSize()
            self?.photoUserImgView.image = resizeImage
            self?.userProfile.foto = resizeImage
        }
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        let xString = instagrammTexField.text?.count
        if instagrammTexField.text != nil &&  Int(xString!) > 10 {
            self.userProfile.instagramUrl = instagrammTexField.text!
        }else{
            displayAlertMessage(messageToDisplay: "Длинна инстагрпмм не меннее 10 символов", viewController: self)
            return
        }
        if nameTextField.text != nil{ self.userProfile.name = nameTextField.text!}
        if surnameTexField.text != nil {self.userProfile.surname = surnameTexField.text!}
        FirebaseUser.init().setUserData(userData: self.userProfile)
        performSegue(withIdentifier: "CreateEventView", sender: "")
        
    }
    
    @IBAction func sexFavoriteButton(_ sender: Any) {
        typePicker = "sexFavorite"
        performSegue(withIdentifier: "showPickersVC", sender: nil)
    }
    @IBAction func ageBtton(_ sender: Any) {
        typePicker = "DateOfB"
        performSegue(withIdentifier: "showPickersVC", sender: nil)
        
    }
    
    @IBAction func sexButton(_ sender: Any) {
        typePicker = "sex"
        performSegue(withIdentifier: "showPickersVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPickersVC" {
            if let pickerVC = segue.destination as? PIckersViewController {
                pickerVC.typePicker = self.typePicker
                pickerVC.callBackToUser = {[unowned self] (pickerResponse) in
                    var s : String = ""
                    s = (pickerResponse as String)
                    
                    switch self.typePicker {
                    case "sexFavorite"?: self.sexFavoriteButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.sexFavorite = ("\(s)")
                    case "sex"?: self.sexButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.sex = ("\(s)")
                    case "DateOfB"?: self.ageButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.age = ("\(s)")
                    default :_ = 1
                    }
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
        stopActivityIndicator()
        let firebaseAuth = Auth.auth()
        do {
            print("выход из Google")
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        UserDefaults.standard.set(false, forKey:"remember")
        userProfile.clear()
        UserDefaults.standard.set("", forKey: "userId")
        UserDefaults.standard.set("", forKey: "email")
        
        // self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
