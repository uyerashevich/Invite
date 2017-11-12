//
//  BaseViewController.swift
//  Invite
//
//  Created by User1 on 12.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.appTintColor
    }
}
