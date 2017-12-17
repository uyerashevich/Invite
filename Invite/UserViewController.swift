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
   
    let imagePick = ImagePickerActionSheet.init()
    var typePicker : String?
    
    var eventListVC = EventListViewController()
    
    var eventList : [EventData] = [] {
        didSet{
            eventListVC.eventList = self.eventList
            print("1111-----\(eventList.count)----list--eventData userVC")
        }
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
//    func showHideStars()->Bool{
//        var starValid = 0
//        //1
//        if userProfile.name.count > 1 && nameTextField.text != "" {
//            starName.isHidden = true
//            starValid += 1
//        }else{starName.isHidden = false}
//
//        //2
//        if userProfile.surname.count > 1 && surnameTexField.text != "" {
//            starValid += 1
//            starLastName.isHidden = true
//        }else{starLastName.isHidden = true}
//
//        //3
//        //age?????
//        starValid += 1
//
//        //4
//        if userProfile.sex.count > 1 && sexButtonOutlet.titleLabel?.text != "Leave Empty" {
//            starValid += 1
//            self.starGender.isHidden = true
//        }else{starGender.isHidden = false}
//        //5
//        if userProfile.sexFavorite.count > 1 && sexFavoriteButtonOutlet.titleLabel?.text != "" {
//            starValid += 1
//            self.starOrientation.isHidden = true
//        }else{starOrientation.isHidden = false}
//        //6
//        if userProfile.aboutMe.count > 5 && aboutMeTextView.text != "" {
//            starValid += 1
//            starLastName.isHidden = true
//        }else{starLastName.isHidden = false}
//
//        if starValid == 6 {return true} else{return false}
//    }
    
    
    func dataForUi(){
        stopActivityIndicator()
    
        let date = NSDate()
        //Orientation
        sexFavoriteButtonOutlet.setTitle(("\(userProfile.sexFavorite)"), for: .normal)
        //Gender
        sexButtonOutlet.setTitle(("\(userProfile.sex)"), for: .normal)
        //age
        if userProfile.age != nil && userProfile.age != "" {
            //   self.starAge.isHidden = true
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
        //last name
        surnameTexField.text = userProfile.surname.capitalized
   
        instagrammTexField.text = userProfile.instagramUrl
        photoUserImgView.image = userProfile.foto
        aboutMeTextView.text = userProfile.aboutMe
        
        
    }
    
    
    
    func validateUserData()->Bool{
        //valid stars
       // guard showHideStars()else{ return false}
        
        //valid istagramm
        let charCount = instagrammTexField.text?.count
        guard Int(charCount!) < 21 else{
            displayAlertMessage(messageToDisplay: "Error Instagram > 20 chars", viewController: self)
            return false
        }
        //valid name surname age sex aboutme sexfavorite
        guard (nameTextField.text != nil && (nameTextField.text?.count)! < 30 ) || (surnameTexField.text != nil && (surnameTexField.text?.count)! < 30 ) || ageButtonOutlet.currentTitle != nil || sexButtonOutlet.currentTitle != nil || sexFavoriteButtonOutlet.currentTitle != nil  else{ displayAlertMessage(messageToDisplay: "Not all fields are filled out and max number of characters in each field is not more than 30 ", viewController: self)
            return false}
        guard aboutMeTextView.text != nil && aboutMeTextView.text.count < 150 else {
            displayAlertMessage(messageToDisplay: "Not all fields are filled out and max number of characters in About Me field is not more than 150 ", viewController: self)
            return false
        }
        self.userProfile.instagramUrl = instagrammTexField.text!
        self.userProfile.name = nameTextField.text!
        self.userProfile.surname = surnameTexField.text!
        
        return true
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
        if validateUserData(){
            FirebaseUser.init().setUserData(userData: self.userProfile)
            performSegue(withIdentifier: "showEventList", sender: self)
        }
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


