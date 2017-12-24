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
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    let imagePick = ImagePickerActionSheet.init()
    var typePicker : String?
    
    var eventListVC = EventListViewController()
    
    var userFotosArray : [UIImage] = [] {
        didSet{
            dataForUi()
        }
    }
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
    // var fotoBool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        stopActivityIndicator()
        registerForKeyboardNotifications()
        
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
        self.aboutMeTextView.delegate = self
        self.dataForUi()
        
        print("\(userProfile.fotoUrl.count)------")
        if userProfile.fotoUrl.count == 1 {
            getImageFromWeb(URL.init(string: userProfile.fotoUrl[0])!, closure: { (image) in
                if let xImage = image{
                    self.userFotosArray.append(xImage)
                }
            })
        }
//            else{
            //загр из firebase storage
                        for i in 0 ..< 5{
                            PostService.downloadsImageFirebase(userId: userProfile.userId, nameImage: "\(i)", completion: { (image) in
                                if let xImage = image{
                                    print("DOWNLOAD IMAGES________")
                                    self.userFotosArray.append(xImage)
                                }
                            })
                            
//            }
        }
        
//        if userProfile.fotoUrl.count < 1  && (userProfile.socialFotoUrl != ""  ) {
//            print("GET SOC IMage")
//            getImageFromWeb(URL.init(string: userProfile.socialFotoUrl)!, closure: { (image) in
//                if let xImage = image{
//                    self.userFotosArray.append(xImage)
//                    PostService.create(for: image!, userId: self.userProfile.userId, nameImage: "0", completion: { (urlImage) in
//                        self.userProfile.fotoUrl.append(urlImage!)
//                    })
//                }
//            })
//        }
//            else{
//            //загр из firebase storage
//            for i in 0 ..< userProfile.fotoUrl.count{
//                //PostService.downloadsImageFirebase(userId: userProfile.userId, nameImage: "\(i)", completion: { (image) in
//                PostService.downloadsImageFirebase(userId: userProfile.userId, nameImage: "\(i)", completion: { (image) in
//                    self.userFotosArray.append(image!)
//                })
//            }
//        }
    }
    func dataForUi(){
        stopActivityIndicator()
        let date = NSDate()
        //age
        if userProfile.age != nil && userProfile.age != "" {
            let ageYear = convertStringToDate(dateString: userProfile.age)
            let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
            ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(userProfile.age) )"), for: .normal)
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
        
        for i in 0 ..< userFotosArray.count{//5
            if i == 0 {photoUserImgView.image = userFotosArray[i]}//[userFotosArray.count - i - 1]}//4
            if i == 1 {image1.image = userFotosArray[i]}//[userFotosArray.count - i - 1]}//3
            if i == 2 {image2.image = userFotosArray[i]}
            if i == 3 {image3.image = userFotosArray[i]}//[userFotosArray.count - i - 1]}//1
            if i == 4 {image4.image = userFotosArray[i]}
        }
        
        aboutMeTextView.text = userProfile.aboutMe
        
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
        
        //   print("--\(nameBool)--\(surnameBool)--\(aboutMeBool)--\(orientationBool)--\(genderBool)--\(ageBool)--\(fotoBool)")
        
        if  nameBool && surnameBool && aboutMeBool && orientationBool && genderBool && ageBool {
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
        //                displayAlertMessage(messageToDisplay: "Max number of characters in Instagram field is not more than 20 and other field is not more than 30", viewController: self)
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
            
            if (self?.userFotosArray.count)! < 5{
                        self?.userFotosArray.insert(resizeImage, at: 0)
            }else{
                 self?.userFotosArray.insert(resizeImage, at: 0)
                    self?.userFotosArray.removeLast()
            }
        }
    }

    @IBAction func saveButton(_ sender: UIButton) {
        self.userProfile.instagramUrl = instagrammTexField.text!
        self.userProfile.name = nameTextField.text!
        self.userProfile.surname = surnameTexField.text!
        self.userProfile.aboutMe = aboutMeTextView.text!
        
        for i in 0 ..< userFotosArray.count{
            PostService.create(for: userFotosArray[i], userId: userProfile.userId, nameImage: "\(i)" , completion: { (urlImage) in
                if self.userProfile.fotoUrl.count < 5 {self.userProfile.fotoUrl.append("\(i)")}
                FirebaseUser.init().setUserData(userData: self.userProfile)
            })
        }
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
                    self.validString(text: "\(s)", sender: "sexFavorite")
                        
                    case "sex"?: self.sexButtonOutlet.setTitle(("\(s)"), for: .normal)
                    self.userProfile.sex = ("\(s)")
                    self.validString(text: "\(s)", sender: "sex")
                        
                    case "DateOfB"?:
                        let ageYear = convertStringToDate(dateString: s)
                        let date = NSDate()
                        let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
                        self.ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(s) )"), for: .normal)
                        self.userProfile.age = ("\(s)")
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


