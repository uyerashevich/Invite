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

class UserViewController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate ,UIPickerViewDataSource {
   
    
    
    @IBOutlet weak var ageButtonOutlet: UIButton!
    @IBOutlet weak var sexFavoriteButtonOutlet: UIButton!
    @IBOutlet weak var sexButtonOutlet: UIButton!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    @IBOutlet weak var pickerViewSex: UIPickerView!
    @IBOutlet weak var imgUserMaskView: UIView!
    @IBOutlet weak var photoUserImgView: UIImageView!
  
    @IBOutlet weak var instagrammTexField: UITextField!
  
    @IBOutlet weak var surnameTexField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    let imagePick = ImagePickerActionSheet.init()
    let sexArray = ["Male", "Female", "Other"]
    let SexFavoriteArray = ["Gay","Lesbi","Bi", "Getero","Other"]
    var pickerType = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.isHidden = true
        pickerViewSex.isHidden = true
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
    @IBAction func ageButton(_ sender: Any) {
        dataPicker.isHidden = false
        dataPicker.setValue(UIColor.white, forKeyPath: "textColor")
        dataPicker.setValue(false, forKeyPath: "highlightsToday")
        pickerViewSex.isHidden = true
        
    }
    
    @IBAction func sexButton(_ sender: Any) {
        let xString = "\(dataPicker.date)"
        ageButtonOutlet.setTitle(xString, for: .normal)
        dataPicker.isHidden = true
        pickerViewSex.isHidden = false
        pickerType = false

    }
    
   
    @IBAction func sexFavoriteButton(_ sender: Any) {
        let xString = "\(dataPicker.date)"
        ageButtonOutlet.setTitle(xString, for: .normal)
        dataPicker.isHidden = true
        pickerViewSex.isHidden = false
        pickerType = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
////        let attributedString = NSAttributedString(string: "Your string name here", attributes: [NSForegroundColorAttributeName : UIColor.WhiteColor()])
//        return attributedString
//        
//    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
       var str = ""
        if dataPicker.isHidden && !pickerViewSex.isHidden && pickerType{
          str = SexFavoriteArray[row]
        }else{if dataPicker.isHidden && !pickerViewSex.isHidden && !pickerType{
            str = sexArray[row]
            }
        }
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if dataPicker.isHidden && !pickerViewSex.isHidden && pickerType{
            return SexFavoriteArray.count
        }else{if dataPicker.isHidden && !pickerViewSex.isHidden && !pickerType{
            return sexArray.count
            }
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if dataPicker.isHidden && !pickerViewSex.isHidden && pickerType{
            return SexFavoriteArray[row]
        }else{if dataPicker.isHidden && !pickerViewSex.isHidden && !pickerType{
            return sexArray[row]
            }
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dataPicker.isHidden && !pickerViewSex.isHidden && pickerType{
            sexFavoriteButtonOutlet.setTitle(SexFavoriteArray[row], for: .normal)
        }else{if dataPicker.isHidden && !pickerViewSex.isHidden && !pickerType{
          sexButtonOutlet.setTitle(sexArray[row], for: .normal)
            }
        }
    }
    @IBAction func saveButton(_ sender: UIButton) {
       
        if instagrammTexField.text != nil{
            self.userProfile.instagramUrl = instagrammTexField.text!
        }
//        if ageTextField.text != nil{  self.userProfile.age = ageTextField.text! }
        if nameTextField.text != nil{ self.userProfile.name = nameTextField.text!}
        if surnameTexField.text != nil {self.userProfile.surname = surnameTexField.text!}
        FirebaseUser.init().setUserData(userData: self.userProfile)
         performSegue(withIdentifier: "CreateEventView", sender: "")
        
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
