//
//  PIckersViewController.swift
//  Invite
//
//  Created by User1 on 25.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class PIckersViewController: BaseViewController, UIPickerViewDelegate ,UIPickerViewDataSource {

    let sexArray = ["Male", "Female", "Other"]
    let SexFavoriteArray = ["Gay","Lesbi","Bi", "Getero","Other"]
    var typePicker : String?
    var valuePicker : String?
    @IBOutlet weak var pckerViewOutlet: UIPickerView!
    @IBOutlet weak var dataPickerOutlet: UIDatePicker!
    
    typealias pickerData = (String) ->()
    var callBackToUser : pickerData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataPickerOutlet.setValue(UIColor.white, forKeyPath: "textColor")
        dataPickerOutlet.setValue(false, forKeyPath: "highlightsToday")
        
        if typePicker == "DateOfB"{
            pckerViewOutlet.isHidden = true
            dataPickerOutlet.isHidden = false
        }else{
            pckerViewOutlet.isHidden = false
            dataPickerOutlet.isHidden = true
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var str = ""
        if typePicker == "sexFavorite"{
            str = SexFavoriteArray[row]
        }else{
            str = sexArray[row]
        }
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if typePicker == "sexFavorite"{
            return SexFavoriteArray.count
        }else{
            return sexArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if typePicker == "sexFavorite"{
            return SexFavoriteArray[row]
        }else{
            return sexArray[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typePicker == "sexFavorite"{
            valuePicker = SexFavoriteArray[row]
        }else{
            valuePicker = sexArray[row]
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        if typePicker == "DateOfB"{
            let stringOfDate = dateNow(needYear: false, date: dataPickerOutlet.date as NSDate)
            valuePicker = ("\(stringOfDate)")
        }
        callBackToUser("\(valuePicker!)")
        dismiss(animated: true, completion: nil)
    }
}
