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
    let imagePick = ImagePickerActionSheet.init()
    var typePicker : String?
    
    var eventList = [EventData]() {
        didSet{
            print("\(eventList.count)----list--eventDataArray.count")
        }
    }
   
    deinit {
        removeKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventsServices.sharedInstance.getListEvent(completion: { (listEvents) in
            self.eventList = listEvents
            print("-SignVC-eventList ----\(self.eventList.count )---")
        })
          self.dataForUi()
        registerForKeyboardNotifications()
     
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    func dataForUi(){
   stopActivityIndicator()

        let date = NSDate()
        sexFavoriteButtonOutlet.setTitle(("\(userProfile.sexFavorite)"), for: .normal)
        sexButtonOutlet.setTitle(("\(userProfile.sex)"), for: .normal)
        if userProfile.age != nil && userProfile.age != "" {
            let ageYear = convertStringToDate(dateString: userProfile.age)
            
            let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
            ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(userProfile.age) )"), for: .normal)
        }else{
            ageButtonOutlet.setTitle((" • ( \(convertDateToString(date: date)) )"), for: .normal)}
        nameTextField.text = userProfile.name.capitalized
        surnameTexField.text = userProfile.surname.capitalized
        instagrammTexField.text = userProfile.instagramUrl
        photoUserImgView.image = userProfile.foto
        aboutMeTextView.text = userProfile.aboutMe
    }
    func validateUserData()->Bool{
          let charCount = instagrammTexField.text?.count
                guard Int(charCount!) < 21 else{
                    displayAlertMessage(messageToDisplay: "Error Instagram > 20 chars", viewController: self)
                    return false
            }
        guard nameTextField.text != nil || surnameTexField.text != nil || ageButtonOutlet.currentTitle != nil || sexButtonOutlet.currentTitle != nil || sexFavoriteButtonOutlet.currentTitle != nil || aboutMeTextView.text != nil else{ displayAlertMessage(messageToDisplay: "Not all fields are filled out", viewController: self)
            return false}
        self.userProfile.instagramUrl = instagrammTexField.text!
        self.userProfile.name = nameTextField.text!
        self.userProfile.surname = surnameTexField.text!
        
        return true
    }
    @IBAction func instagrammChanged(_ sender: UITextField) {
        if let charCount = instagrammTexField.text?.count {
            charCountInstagramm.text = String(charCount) }
    }
    //для убирания клавы с экрана/////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            performSegue(withIdentifier: "showEventList", sender: "")
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

     
     //   stopActivityIndicator()
        let firebaseAuth = Auth.auth()
        do {
            print("выход из Google")
            try firebaseAuth.signOut()
            userProfile.clear()
            UserDefaults.standard.set("", forKey: "userId")
            UserDefaults.standard.set("", forKey: "email")
            
           // eventList.clearArray()
//            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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


