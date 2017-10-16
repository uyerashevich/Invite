//
//  Convertible.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation


protocol Convertible {
    
    func convertToDictionary() -> [String : Any]
    
    init?(fromDictionary: [String : Any])
}
