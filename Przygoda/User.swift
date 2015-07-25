//
//  User.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation

class User {
    var id: Int
    var social_id: String
    var username: String
    var email: String
    var registered_on: Int64
    
    init(id: Int, social_id: String, username: String, email: String, registered_on: Int64) {
        self.id = id
        self.social_id = social_id
        self.username = username
        self.email = email
        self.registered_on = registered_on
    }
    
    func login() {
    }
}