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
    @IBOutlet weak var nextButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var charCountInstagramm: UILabel!
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var ageButtonOutlet: UIButton!
    @IBOutlet weak var sexFavoriteButtonOutlet: UIButton!
    @IBOutlet weak var sexButtonOutlet: UIButton!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var imgUserMaskView: UIView!
    @IBOutlet weak var photoUserImgView: UIImageView!
    @IBOutlet weak var instagrammTexField: UITextField!
    @IBOutlet weak var surnameTexField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var starName: UILabel!
    @IBOutlet weak var starLastName: UILabel!
    @IBOutlet weak var starAge: UILabel!
    @IBOutlet weak var starAboutMe: UILabel!
    @IBOutlet weak var starOrientation: UILabel!
    @IBOutlet weak var starGender: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    let imagePick = ImagePickerActionSheet.init()
    var typePicker : String?
    
    var eventListVC = EventListViewController()
    
    var eventList : [EventData] = [] {
        didSet{
            eventListVC.eventList = self.eventList
        //    print("1111-----\(eventList.count)----list--eventData userVC")
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    var instaBool = false
    var nameBool = false
    var surnameBool = false
    var aboutMeBool = false
    
//    var xTextField : String = ""{
//        didSet{
//            if aboutMeTextView.text.count > 3 && aboutMeTextView.text.count < 150 {aboutMeBool = true}else{aboutMeBool = false}
//            if instaBool && nameBool && surnameBool && aboutMeBool{
//                 print("HIDE NEXT")
//            }
//
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopActivityIndicator()
        registerForKeyboardNotifications()
        
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
        self.dataForUi()
        
    }
   
    func dataForUi(){
        stopActivityIndicator()
        
        let date = NSDate()
        //Orientation
        sexFavoriteButtonOutlet.setTitle(("\(userProfile.sexFavorite)"), for: .normal)
        //Gender
        sexButtonOutlet.setTitle(("\(userProfile.sex)"), for: .normal)
        //age
        if userProfile.age != nil && userProfile.age != "" {
            let ageYear = convertStringToDate(dateString: userProfile.age)
            let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
            //  if Int(timeInterval) < 16 { self.starAge.isHidden = false }
            ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(userProfile.age) )"), for: .normal)
        }else{
            // self.starAge.isHidden = false
            ageButtonOutlet.setTitle((" • ( \(convertDateToString(date: date)) )"), for: .normal)
        }
        //name
        nameTextField.text = userProfile.name.capitalized
        
//        if (userProfile.name.count) > 2 && (userProfile.name.count) < 30{nameBool = true}else{nameBool = false}
        
        //last name
        surnameTexField.text = userProfile.surname.capitalized
//         if (userProfile.surname.count) > 2 && (userProfile.surname.count) < 30{surnameBool = true}else{surnameBool = false}
        //instagram
        instagrammTexField.text = userProfile.instagramUrl
//        if (userProfile.instagramUrl.count) < 20{instaBool  = true}else{instaBool  = false}
        
        photoUserImgView.image = userProfile.foto
        
        //about me
        aboutMeTextView.text = userProfile.aboutMe
//         if userProfile.aboutMe.count > 3 && userProfile.aboutMe.count < 150 {aboutMeBool = true}else{aboutMeBool = false}
        validString(text: userProfile.name, sender: "Name")
        validString(text: userProfile.surname, sender: "surname")
        validString(text: userProfile.instagramUrl, sender: "instagramm")
       // validString(text: userProfile.aboutMe, sender: "aboutMe")
    }
    func validString(text : String, sender : String){
    print("VALIDATION")
        switch sender {
        case "instagramm" :  if (text.count) < 20{instaBool  = true}else{instaBool  = false}
        case "Name" : if (text.count) > 2 && (text.count) < 30{nameBool = true}else{nameBool = false}
        case "surname": if (text.count) > 2 && (text.count) < 30{surnameBool = true}else{surnameBool = false}
        default:  _ = 1
        }
        if aboutMeTextView.text.count > 2 && aboutMeTextView.text.count < 150{aboutMeBool = true}else{aboutMeBool = false}
        print("\(instaBool)--\(nameBool)--\(surnameBool)--\(aboutMeBool)--")
        if instaBool && nameBool && surnameBool && aboutMeBool{
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
        }else {
            nextButton.layer.opacity = 0.5
            nextButton.isEnabled = false}
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        validString(text: textField.text!, sender: textField.placeholder!)
//                displayAlertMessage(messageToDisplay: "Max number of characters in Instagram field is not more than 20 and other field is not more than 30", viewController: self)
    }
    
    //для убирания клавы с экрана/////////
    @IBAction func tapOnView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func instagrammChanged(_ sender: UITextField) {
        if let charCount = instagrammTexField.text?.count {
            charCountInstagramm.text = String(20 - charCount) }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        self.userProfile.instagramUrl = instagrammTexField.text!
        self.userProfile.name = nameTextField.text!
        self.userProfile.surname = surnameTexField.text!
        self.userProfile.aboutMe = aboutMeTextView.text!
            FirebaseUser.init().setUserData(userData: self.userProfile)
            performSegue(withIdentifier: "showEventList", sender: self)
      
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
    
    @IBAction func backButton(_ sender: UIButton) {
        
        
        stopActivityIndicator()
        let firebaseAuth = Auth.auth()
        GIDSignIn.sharedInstance().disconnect()
        GIDSignIn.sharedInstance().signOut()
        do {
            print("выход из Google")
            try firebaseAuth.signOut()
            
            userProfile.clear()
            UserDefaults.standard.set("", forKey: "userId")
            
            //            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            
            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventList"{
            if let eventListVC = segue.destination as? EventListViewController {
                self.eventListVC = eventListVC
            }
        }
        
        if segue.identifier == "showPickersVC" {
            if let pickerVC = segue.destination as? PIckersViewController {
                pickerVC.typePicker = self.typePicker
                pickerVC.callBackToUser = {[unowned self] (pickerResponse) in
                    
                    let s = (pickerResponse as String)
                    
                    switch self.typePicker {
                    case "sexFavorite"?: self.sexFavoriteButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.sexFavorite = ("\(s)")
                    case "sex"?: self.sexButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.sex = ("\(s)")
                        
                    case "DateOfB"?:
                        
                        let ageYear = convertStringToDate(dateString: s)
                        let date = NSDate()
                        let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
                        self.ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(s) )"), for: .normal)
                        self.userProfile.age = ("\(s)")
                    default :_ = 1
                    }
                }
            }
        }
    }
    //MARK: - Keyboard Hide/Show
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        self.view.frame.origin.y = -220 * (620 / (self.view.frame.height * 1))
    }
    
    @objc func kbWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
}


