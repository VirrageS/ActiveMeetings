//
//  Mode.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation

class Mode {
    var name: String
    
    var type: ModeTypes
    
    init(type: ModeTypes) {
        self.name = type.rawValue
        
        self.type = type
    }
}

enum ModeTypes: String {
    case Sporty = "Sportowy"
    case Amateur = "Amatorski"
    case Recreational = "Rekreacyjny"
    
    case Downhill = "Downhill"
}