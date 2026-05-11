//
//  UserManage.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

//this does not do anything with login
//it only creates a unique key and saves it on the device, so they can modify reports later
final class UserManager {
    
    //key used to save and read the ID
    private static let userIDKey = "localUserID"
    
    
    //returns the existing local ID if already exist
    //if none, creates a new UUID and saves it
    static func getOrCreateUserID() -> String {
        if let existingID = UserDefaults.standard.string(forKey: userIDKey) {
            return existingID
        }
        
        let newID = UUID().uuidString
        UserDefaults.standard.set(newID, forKey: userIDKey)
        return newID
    }
}
