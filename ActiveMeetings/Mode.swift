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
    
    init(name: ModeTypes) {
        self.name = name.rawValue
    }
}

enum ModeTypes: String {
    case Sporty = "Sportowy"
    case Amateur = "Amatorski"
    case Recreational = "Rekreacyjny"
    
    case Downhill = "Downhill"
}