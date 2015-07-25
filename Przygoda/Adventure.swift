//
//  Adventure.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation
import UIKit

class Adventure: NSObject {
    var id: Int64
    var creator_id: Int64
    var creator_username: String
    var joined: Int64
    var date: NSDate
    var participants: [(id: Int64, username: String)]
    var image_url: String
    
    init(id: Int64, creator_id: Int64, creator_username: String, joined: Int64, date: NSDate, participants: [(id: Int64, username: String)], image_url: String) {
        self.id = id
        self.creator_id = creator_id
        self.creator_username = creator_username
        self.joined = joined
        self.date = date
        self.participants = participants
        self.image_url = image_url
    }
    
    func getStaticImage() -> UIImage? {
        var escapedURL = image_url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        var url = NSURL(string: escapedURL)
        if let data = NSData(contentsOfURL: url!) {
            // return image
            return UIImage(data: data)
        }
        
        return nil
    }
}