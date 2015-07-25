//
//  Adventure.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation

class Adventure {
    var id: Int64
    var creator_id: Int64
    var creator_name: String
    var joined: Int64
    var date: NSDate
    var participants: [(id: Int64, name: String)]
    var image_url: String
    
    init(id: Int64, creator_id: Int64, creator_name: String, joined: Int64, date: NSDate, participants: [(id: Int64, name: String)], image_url: String) {
        self.id = id
        self.creator_id = creator_id
        self.creator_name = creator_name
        self.joined = joined
        self.date = date
        self.participants = participants
        self.image_url = image_url
    }
}