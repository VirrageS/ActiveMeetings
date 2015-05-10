//
//  Account.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 11.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation

class Account {
    var id: Int64
    var username: String
    var password: String
    
    var realName: String
    var realSurname: String
    var nick: String
    
    init(id: Int64, username: String, password: String, realName: String, realSurname: String, nick: String) {
        self.id = id
        
        self.username = username
        self.password = password
        
        self.realName = realName
        self.realSurname = realSurname
        self.nick = nick
    }
    
    // TODO: function which gets new account ID for the user
    func getNewAccountID() -> Int64 {
        return 10
    }
}
