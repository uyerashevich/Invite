//
//  Cache.swift
//  Invite
//
//  Created by User1 on 12.10.17.
//  Copyright © 2017 User1. All rights reserved.
//


import Foundation
import Locksmith

class Cache {
    
    class func save<T: Convertible>(userAccountString: String, _ model: T) {
        if let _ = Locksmith.loadDataForUserAccount(userAccount: userAccountString) {
            do {
                try Locksmith.updateData(data: model.convertToDictionary(), forUserAccount: userAccountString)
            } catch {
                print(error)
                print("Cache.save() -- didn't update data")
            }
            
        } else {
            do {
                try Locksmith.saveData(data: model.convertToDictionary(), forUserAccount: userAccountString)
            } catch {
                print(error)
                print("Cache.save() -- didn't save data")
            }
        }
    }
    
    class func load<T: Convertible>(userAccountString: String, _:T.Type) -> T? {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: userAccountString)
        if let dictionaryValue = dictionary {
            return T(fromDictionary: dictionaryValue)
        }
        return nil
    }
    
    class func clear<T: Convertible>(userAccountString: String, _: T.Type) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: userAccountString)
        } catch {
        }
    }
    
    private init() {
    }
}
