//
//  UIViewEtensions.swift
//  Invite
//
//  Created by User1 on 14.11.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit

extension UIView {
    
        func addShadowView(width:CGFloat=0.2, height:CGFloat=3, Opacidade:Float=0.5, maskToBounds:Bool=false, radius:CGFloat=2){
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize(width: width, height: height)
            self.layer.shadowRadius = radius
            self.layer.shadowOpacity = Opacidade
            self.layer.masksToBounds = maskToBounds
        }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    

        @IBInspectable var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
        
        @IBInspectable var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
        
        @IBInspectable var borderColor: UIColor? {
            get {
                return UIColor(cgColor: layer.borderColor!)
            }
            set {
                layer.borderColor = newValue?.cgColor
            }
        }

}
