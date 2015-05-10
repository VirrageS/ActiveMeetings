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
    
    init(name: SportTypes, modes: [Mode]) {
        self.name = name.rawValue
        self.modes = modes
    }
}

enum SportTypes: String {
    case Bicycle = "Rower"
    case Basketball = "Koszykówka"
    case Football = "Piłka nożna"
    case Volleyball = "Siatkówka"
}