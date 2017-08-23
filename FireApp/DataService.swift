//
//  DataService.swift
//  FireApp
//
//  Created by KO on 23.08.2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS : DatabaseReference {
        return _REF_POSTS
    }
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    
    func createFirebaseDBUser(uid: String,userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    var REF_USER_CURRENT: DatabaseReference {
        //let uid = KeychainWrapper.stringForKey(KEY_UID)
        //let uid = KeychainWrapper.set(KEY_UID)
        let uid = KeychainWrapper.defaultKeychainWrapper.string(forKey: "uid")
        let user = REF_USERS.child(uid!)
        return user
    }
    
}
