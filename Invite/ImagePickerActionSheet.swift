//
//  ImagePickerActionSheet.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerActionSheet :NSObject,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    var myImage = UIImage()
    var onDataUpdate: ((_ image: UIImage) -> Void)?
    
    override init() {}
    
    func showCameraLibrary(view : UIViewController){
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
       
        let myActionSheet = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        let firstButton = UIAlertAction(title: "Сделать новое фото", style: .default){
            (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.sourceType = .camera
                view.present(self.imagePicker, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Camera not present", message: nil, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in }
                alertController.addAction(OKAction)
                view.present(alertController, animated: true, completion:nil)
            }
        }
        let secondButton = UIAlertAction(title: "Выбрать фото из альбома ", style: .default){
            (action: UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            view.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        {(action: UIAlertAction) in   }
        myActionSheet.addAction(firstButton)
        myActionSheet.addAction(secondButton)
        myActionSheet.addAction(cancelButton)
        view.present(myActionSheet, animated: true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            myImage = selectedImage
        }
        imagePicker.dismiss(animated: true) {
            self.imgRequest()
        }
      //  imagePicker.dismiss(animated: true, completion: { (finished) -> Void in
        //    self.imgRequest()
       // })
    }
    func imgRequest() {
        let image = myImage
        onDataUpdate?(image)
    }
    
}
