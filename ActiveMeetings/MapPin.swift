//
//  MapPin.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D
    
    var event: Event
    
    init(event: Event) {
        self.title = event.name
        self.subtitle = event.description
        self.coordinate = event.coordinate
        
        self.event = event
    }
}