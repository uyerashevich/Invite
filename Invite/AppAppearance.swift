//
//  AppAppearance.swift
//  Invite
//
//  Created by User1 on 14.11.17.
//  Copyright © 2017 User1. All rights reserved.
//
import Foundation
import UIKit

class AppAppearance {
    
    private init(){}
    
   
    class public func SetUp(){
        setUpNavigationBarAppearance()
        setUpTabBarAppearance()
    }
    
    class private func setUpTabBarAppearance(){
        let customTabBar = UITabBar.appearance()
        let customTabBarItem = UITabBarItem.appearance()
        
        customTabBar.isTranslucent = false
       // customTabBar.backgroundColor = UIColor.red
        
        customTabBarItem.badgeColor = UIColor.black
    }
    
    class private func setUpNavigationBarAppearance(){
        let customNavigationBar = UINavigationBar.appearance()
        let customBarButtonItem = UIBarButtonItem.appearance()
        
       // customNavigationBar.barTintColor = UIColor.init(hexString: "6DAB28")
        customNavigationBar.barTintColor = UIColor.black
        customNavigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        customNavigationBar.isTranslucent = false
       
        //let backImage = UIImage(named: "back_white")
//        customNavigationBar.backIndicatorImage = backImage
//        customNavigationBar.backIndicatorTransitionMaskImage = backImage
//
//        customNavigationBar.tintColor = UIColor.white
//        customBarButtonItem.tintColor = UIColor.white
        
    }
}
