//
//  DataService.swift
//  Login
//
//  Created by Fareen on 1/25/18.
//  Copyright © 2018 Fareen. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = Database.database().reference()

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    // MARK: - DB refrences
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func updateFirebaseUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).child("profile").updateChildValues(userData)
    }
    
}
