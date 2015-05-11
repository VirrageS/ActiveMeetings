//
//  Event.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation
import MapKit


class Event {
    /// ID of the event
    var id: Int64
    
    /// Name of the event
    var name: String
    
    /// Description of the event
    var description: String
    
    /// Location of the event
    var coordinate: CLLocationCoordinate2D
    
    // TODO: Creator should be an account
    var creator: String
    
    var sport: SportTypes
    var mode: ModeTypes
    
    // TODO: Participants should be an array/list of ids/accounts of people who joined event
    /// Pariticipants which joined to the event
    var pariticipants: Int = 0
    
    init(id: Int64, name: String, description: String, coordinate: CLLocationCoordinate2D, creator: String, sport: SportTypes, mode: ModeTypes) {
        self.id = id
        self.name = name
        self.description = description
        self.coordinate = coordinate
        
        self.creator = creator
        
        self.sport = sport
        self.mode = mode
    }

    func addParticipant() {
        pariticipants++
    }
    
    func removeParticipant() {
        pariticipants--
    }
}