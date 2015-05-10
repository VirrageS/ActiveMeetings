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
    var name: String
    var description: String
    var creator: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, description: String, coordinate: CLLocationCoordinate2D, creator: String) {
        self.name = name
        self.description = description
        self.coordinate = coordinate
        
        self.creator = creator
    }
}