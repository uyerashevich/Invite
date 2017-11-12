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

class UserViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgUserMaskView: UIView!
    @IBOutlet weak var photoUserImgView: UIImageView!
    @IBOutlet weak var sexButtonOutlet: UIButton!
    @IBOutlet weak var instagrammTexField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var surnameTexField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    let imagePick = ImagePickerActionSheet.init()
    var userProfile = UserProfile.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleForUIProfile()
        //для убирания клавы с экрана/////////
        self.instagrammTexField.delegate = self
        self.ageTextField.delegate = self
        self.surnameTexField.delegate = self
        self.nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
        if userProfile.sex != "Male" && userProfile.sex != "Female"{sexButtonOutlet.setTitle("Gender", for: .normal)}
        else{sexButtonOutlet.setTitle(userProfile.sex, for: .normal)}
        nameTextField.text = userProfile.name
        surnameTexField.text = userProfile.surname
        ageTextField.text = userProfile.age
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
    @IBAction func sexButton(_ sender: UIButton) {
        if sexButtonOutlet.titleLabel?.text == "Male"{
            sender.setTitle("Female", for: .normal)
        }else{ sender.setTitle("Male", for: .normal)}
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        self.userProfile.sex = (sexButtonOutlet.titleLabel?.text)!
        if instagrammTexField.text != nil{
            self.userProfile.instagramUrl = instagrammTexField.text!
        }
        if ageTextField.text != nil{  self.userProfile.age = ageTextField.text! }
        if nameTextField.text != nil{ self.userProfile.name = nameTextField.text!}
        if surnameTexField.text != nil {self.userProfile.surname = surnameTexField.text!}
        FirebaseUser.init().setUserData(userData: self.userProfile)
         performSegue(withIdentifier: "CreateEventView", sender: "")
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CreateEventView" {
//            //            let destinationVC = segue.destination as! FiltersViewController
//            //            destinationVC.eventDataArray = self.eventDataArray
//        }
//    }
    func styleForUIProfile(){
        photoUserImgView.layer.cornerRadius = photoUserImgView.frame.width / 2
        photoUserImgView.clipsToBounds = true
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
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
