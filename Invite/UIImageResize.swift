//
//  UIImageResize.swift
//  Invite
//
//  Created by User1 on 10.10.17.
//  Copyright © 2017 User1. All rights reserved.
//


import UIKit

let kMaximumImageSize: CGFloat = 300.0

extension UIImage {
    
    func fixSize() -> UIImage {
        if self.size.width < kMaximumImageSize && self.size.height < kMaximumImageSize {
            return self
        }
        
        let hScale = kMaximumImageSize / self.size.width
        let vScale = kMaximumImageSize / self.size.height
        let scale = (hScale > vScale ? hScale : vScale)
        let newSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        if let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        
        UIGraphicsEndImageContext()
        return self;
    }
    
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        if let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        
        UIGraphicsEndImageContext()
        return self;
    }
}
