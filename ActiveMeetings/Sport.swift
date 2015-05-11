//
//  Sport.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation

class Sport {
    var name: String
    
    var modes: [Mode]
    
    var type: SportTypes
    
    init(type: SportTypes, modes: [Mode]) {
        self.name = type.rawValue
        self.modes = modes
        
        self.type = type
    }
}

enum SportTypes: String {
    case Bicycle = "Rower"
    case Basketball = "Koszykówka"
    case Rollers = "Rolki"
    case Football = "Piłka nożna"
    case Volleyball = "Siatkówka"
}