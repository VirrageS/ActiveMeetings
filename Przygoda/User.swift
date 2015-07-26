//
//  User.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation

class User: NSObject {
    /// ID of user
    var id: Int64
    /// Facebooks social id
    var social_id: String
    /// Full name of the user
    var username: String
    /// User's email
    var email: String
    /// Date when user has been registered
    var registered_on: Int64
    
    init(id: Int64, social_id: String, username: String, email: String, registered_on: Int64) {
        self.id = id
        self.social_id = social_id
        self.username = username
        self.email = email
        self.registered_on = registered_on
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt64(self.id, forKey: "id")
        aCoder.encodeObject(self.social_id, forKey: "social_id")
        aCoder.encodeObject(self.username, forKey: "username")
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeInt64(self.registered_on, forKey: "registered_on")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInt64ForKey("id") as Int64
        self.social_id = aDecoder.decodeObjectForKey("social_id") as! String
        self.username = aDecoder.decodeObjectForKey("username") as! String
        self.email = aDecoder.decodeObjectForKey("email") as! String
        self.registered_on = aDecoder.decodeInt64ForKey("registered_on") as Int64
    }
}

/// Login user to system
/// Saves user in system for key "current_user"
///
/// :param: user User which will be logged to system
func loginUser(user: User) {
    var encodedObject: NSData = NSKeyedArchiver.archivedDataWithRootObject(user)
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(encodedObject, forKey: "current_user")
    defaults.synchronize()
}

/// Allows to get current logged user in the system
/// Get user for key "current_user"
///
/// :returns: user if has been logged before, nil otherwise
func currentUser() -> User? {
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var encodedObject: NSData = defaults.objectForKey("current_user") as! NSData
    var user: User? = NSKeyedUnarchiver.unarchiveObjectWithData(encodedObject) as? User
    return user
}