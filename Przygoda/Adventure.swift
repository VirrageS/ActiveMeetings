//
//  Adventure.swift
//  Przygoda
//
//  Created by Janusz Marcinkiewicz on 24.07.2015.
//  Copyright (c) 2015 sportoweprzygody. All rights reserved.
//

import Foundation
import UIKit

/**
    Describes abstract model of adventure
*/
class Adventure: NSObject {
    /// ID of the adventure
    var id: Int64
    /// Creator of adventure ID
    var creator_id: Int64
    /// Creator of adventure username
    var creator_username: String
    /// Number of participants who joined the adventure
    var joined: Int64
    /// Date when the adventure ends
    var date: Int64
    /// Array of adventure participants
    var participants: [(id: Int64, username: String)]
    /// Static image url of adventure
    var image_url: String
    
    // TODO: add "mode", "mode_name" var
    /**
        Init adventure.

        :param: id ID of the adventure
        :param: creator_id Creator ID of the adventure
        :param: creator_username Creator username
        :param: joined Number of joined participants
        :param: date Date when adventure ends
        :param: participants Participants of the adventure
        :param: image_url Image url of adventure
    */
    init(id: Int64, creator_id: Int64, creator_username: String, joined: Int64, date: Int64, participants: [(id: Int64, username: String)], image_url: String) {
        self.id = id
        self.creator_id = creator_id
        self.creator_username = creator_username
        self.joined = joined
        self.date = date
        self.participants = participants
        self.image_url = image_url
    }
    
    /**
        Returns adventure static image from adventure image url

        :returns: nil if cannot get image, image otherwise
    */
    func getStaticImage() -> UIImage? {
        var escapedURL = image_url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        var url = NSURL(string: escapedURL)
        if let data = NSData(contentsOfURL: url!) {
            // return image
            return UIImage(data: data)
        }
        
        return nil
    }
    
    // TODO: finish function
    /** 
        Updates info from api and return result

        :returns: false if adventure does not exists, true otherwise
    */
    func update() -> Bool {
        
        return true
    }
}
