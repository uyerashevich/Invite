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

class UserViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate{ //
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
    var nameBool = false
    var surnameBool = false
    var aboutMeBool = false
    var ageBool = false
    var orientationBool = false
    var genderBool = false
    var fotoBool = false
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL+ PHOTO
         PostService.create(for: #imageLiteral(resourceName: "logo.jpg"))
//        let storage = Storage.storage()
        // Create a storage reference from our storage service
//        let storageRef = storage.reference()
//        let tempImageRef = storageRef.child("tmpDir/tmp.jpg")
//
//
//        let image = UIImage(named: "logo.jpg")
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//
//        tempImageRef.putData(UIImageJPEGRepresentation(image!, 0.8)!, metadata: metadata, completion: { (data, error) in
//            if error == nil{
////                for i in metadata.downloadURLs!{
////                print(i)
////                }
//                print("upload---\(metadata.downloadURL()) OK")
//            }else{ print(error)}
//        })
        
        
       
//        tempImageRef.getData(maxSize: 1*1000*1000) { (data, error) in
//            if error == nil{
//                self.photoUserImgView.image = UIImage(data: data!)
//                            }else{ print(error)}
//        }
        
        
        stopActivityIndicator()
        registerForKeyboardNotifications()
        
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
        self.aboutMeTextView.delegate = self
        self.dataForUi()
        
    }
   
    func dataForUi(){
        stopActivityIndicator()
        let date = NSDate()
        //age
        if userProfile.dateBirth != nil && userProfile.dateBirth  != "" {
            let ageYear = convertStringToDate(dateString: userProfile.dateBirth)
            let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
            ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(userProfile.dateBirth) )"), for: .normal)
              validString(text: "\(Int(timeInterval))", sender: "DateOfB")
        }else{
            ageBool = false
            ageButtonOutlet.setTitle((" • ( \(convertDateToString(date: date)) )"), for: .normal)
        }
        
        sexFavoriteButtonOutlet.setTitle(("\(userProfile.sexFavorite)"), for: .normal)
        sexButtonOutlet.setTitle(("\(userProfile.sex)"), for: .normal)
        nameTextField.text = userProfile.name.capitalized
        surnameTexField.text = userProfile.surname.capitalized
        instagrammTexField.text = userProfile.instagramUrl
        
        //upload foto from URL
       // photoUserImgView.image = userProfile.foto
        aboutMeTextView.text = userProfile.aboutMe
        //upload foto from URL
       // if userProfile.foto != #imageLiteral(resourceName: "pixBlack"){fotoBool = true}else{fotoBool = false}
        validString(text: userProfile.aboutMe, sender: "aboutMe")
        validString(text: userProfile.sex, sender: "sex")
        validString(text: userProfile.sexFavorite, sender: "sexFavorite")
        validString(text: userProfile.name, sender: "Name")
        validString(text: userProfile.surname, sender: "Surname")

    }
    func validString(text : String, sender : String){
        switch sender {
        case "DateOfB" :  if let dateB = Int(text) {
                                if dateB > 14 {ageBool  = true}else{ageBool  = false}
                            }
        case "sex" :  if text != "Leave Empty" && text != "" {genderBool  = true}else{genderBool  = false}
        case "sexFavorite" :  if (text.count) > 1 {orientationBool  = true}else{orientationBool  = false}
        case "Name" : if (text.count) > 2 && (text.count) < 30 {nameBool = true}else{nameBool = false}
        case "Surname": if (text.count) > 2 && (text.count) < 30 {surnameBool = true}else{surnameBool = false}
        case "aboutMe": if (text.count) < 151{aboutMeBool = true}else{
            displayAlertMessage(messageToDisplay: "Max number of characters in About Me field is not more than 150. \n Your text \(text.count)", viewController: self)
            aboutMeBool = false
            }
        default:  _ = 1
        }
        
        print("--\(nameBool)--\(surnameBool)--\(aboutMeBool)--\(orientationBool)--\(genderBool)--\(ageBool)--\(fotoBool)")

        if  nameBool && surnameBool && aboutMeBool && orientationBool && genderBool && ageBool && fotoBool {
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
        }else {
            nextButton.layer.opacity = 0.5
            nextButton.isEnabled = false}
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        validString(text: aboutMeTextView.text, sender: "aboutMe")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        validString(text: textField.text!, sender: textField.placeholder!)
    }
    
    //для убирания клавы с экрана/////////
    @IBAction func tapOnView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func instagrammChanged(_ sender: UITextField) {
        if let charCount = instagrammTexField.text?.count {
            charCountInstagramm.text = String(20 - charCount)
            if (20 - charCount) < 1 { instagrammTexField.text?.removeLast() }
        }
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
            
            //upload foto from URL
           // self?.userProfile.foto = resizeImage
         //   if self?.userProfile.foto != #imageLiteral(resourceName: "pixBlack"){self?.fotoBool = true}else{self?.fotoBool = false}
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.userProfile.instagramUrl = instagrammTexField.text!
        self.userProfile.name = nameTextField.text!
        self.userProfile.surname = surnameTexField.text!
        self.userProfile.aboutMe = aboutMeTextView.text!
        UserManager.sharedInstance.setUserData(userData: self.userProfile)
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
                    self.validString(text: "\(s)", sender: "sexFavorite")
                        
                    case "sex"?: self.sexButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.sex = ("\(s)")
                    self.validString(text: "\(s)", sender: "sex")
                        
                    case "DateOfB"?:
                        let ageYear = convertStringToDate(dateString: s)
                        let date = NSDate()
                        let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
                        self.ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(s) )"), for: .normal)
                        self.userProfile.dateBirth = ("\(s)")
                        self.validString(text: "\(Int(timeInterval))", sender: "DateOfB")
                        
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


