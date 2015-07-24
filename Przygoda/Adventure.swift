//
//  Adventure.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation

class Adventure {
    var id: Int
    var creator_id: Int
    var creator_name: String
    var joined: Int
    var date: NSDate
    
    
    init(id: Int, creator_id: Int, creator_name: String, joined: Int, date: NSDate) {
        self.id = id
        self.creator_id = creator_id
        self.creator_name = creator_name
        self.joined = joined
        self.date = date
    }
}