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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        // 1. Регистрируем тап, для скрытия клавиатуры
        //        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapView))
        //        view.addGestureRecognizer(tapGesture)
        
        //  scrollViewOutlet.contentSize.height = 800
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.dataForUi()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //   self.removeObservers()
    }
    
    //    func addObservers() {
    //        // Нотификация которая появляется при открытии клавиатуры
    //        // Notification that appears when you open the keyboard
    //        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil, using: {(_ note: Notification) -> Void in
    //            self.keyboardWillShow(note)
    //        })
    //        // Нотификация которая появляется при закрытии клавиатуры
    //        // Notification that appears when you close the keyboard
    //        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil, using: {(_ note: Notification) -> Void in
    //            self.keyboardWillHide(note)
    //        })
    //    }
    
    //    func keyboardWillShow(_ notification: Notification) {
    //        // Получаем словарь - Get Dictionary
    //        let userInfo = notification.userInfo
    //        if userInfo != nil {
    //            // Вытаскиваем frame который описывает кооридинаты клавиатуры
    //            // Pull out frame which describes the coordinates of the keyboard
    //            let frame: CGRect? = (userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
    //            // Создаем отступ по высоте клавиатуры
    //            // Create an inset at the height of the keyboard
    //            let contentInset: UIEdgeInsets = UIEdgeInsetsMake(0, 0, frame!.height, 0)
    //            // Применяем отступ - Apply the inset
    //            scrollViewOutlet.contentInset = contentInset
    //        }
    //    }
    //    func keyboardWillHide(_ notification: Notification) {
    //        // Отменяем отступ - Cancel inset
    //        self.scrollViewOutlet.contentInset = UIEdgeInsets.zero
    //    }
    //
    //    func removeObservers() {
    //        // Отписываемся от нотификаций - Unsubscribe from notifications
    //        NotificationCenter.default.removeObserver(self)
    //    }
    //    @objc func didTapView(_ gesture: UITapGestureRecognizer) {
    //        view.endEditing(true)
    //    }
    
    
  
  
    
    func dataForUi(){
        sexFavoriteButtonOutlet.setTitle(("\(userProfile.sexFavorite)"), for: .normal)
        sexButtonOutlet.setTitle(("\(userProfile.sex)"), for: .normal)
        if userProfile.age != nil {
            let ageYear = convertStringToDate(dateString: userProfile.age)
            let date = NSDate()
            let timeInterval = date.timeIntervalSince(ageYear) / 60 / 60 / 24 / 365
            ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(userProfile.age) )"), for: .normal)
        }
        nameTextField.text = userProfile.name.capitalized
        surnameTexField.text = userProfile.surname.capitalized
        instagrammTexField.text = userProfile.instagramUrl
        photoUserImgView.image = userProfile.foto
        aboutMeTextView.text = userProfile.aboutMe
    }
    func validateUserData()->Bool{
        let xString = instagrammTexField.text?.count
        guard Int(xString!) < 1 || Int(xString!) > 9 || instagrammTexField.text == nil else{
            displayAlertMessage(messageToDisplay: "Instagram > 10 chars", viewController: self)
            return false
        }
        guard nameTextField.text != nil || surnameTexField.text != nil || ageButtonOutlet.currentTitle != nil || sexButtonOutlet.currentTitle != nil || sexFavoriteButtonOutlet.currentTitle != nil || aboutMeTextView.text != nil else{ displayAlertMessage(messageToDisplay: "Not all fields are filled out", viewController: self)
            return false}
        self.userProfile.instagramUrl = instagrammTexField.text!
        self.userProfile.name = nameTextField.text!
        self.userProfile.surname = surnameTexField.text!
        self.userProfile.aboutMe = aboutMeTextView.text
        return true
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
        
        stopActivityIndicator()
        let firebaseAuth = Auth.auth()
        do {
            print("выход из Google")
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        userProfile.clear()
        UserDefaults.standard.set("", forKey: "userId")
        UserDefaults.standard.set("", forKey: "email")
        EventList.sharedInstance.clearArray()
        // self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
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
                            // print(timeInterval % 100 )
                            self.ageButtonOutlet.setTitle(("\(Int(timeInterval)) • ( \(s) )"), for: .normal)
                            self.userProfile.age = ("\(s)")
                        default :_ = 1
                        }
                    }
                }
            }
        }
    }

