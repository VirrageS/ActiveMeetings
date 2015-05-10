//
//  Const.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import Foundation

let sports = [
    Sport(
        name: SportTypes.Bicycle,
        modes: [
            Mode(name: ModeTypes.Recreational),
            Mode(name: ModeTypes.Sporty),
            Mode(name: ModeTypes.Amateur),
            Mode(name: ModeTypes.Downhill)
        ]
    ),
    
    Sport(
        name: SportTypes.Football,
        modes: [
            Mode(name: ModeTypes.Amateur),
            Mode(name: ModeTypes.Sporty)
        ]
    ),
    
    Sport(
        name: SportTypes.Basketball,
        modes: [
            Mode(name: ModeTypes.Sporty),
            Mode(name: ModeTypes.Amateur)
        ]
    ),
    
    Sport(
        name: SportTypes.Rollers,
        modes: [
            Mode(name: ModeTypes.Sporty)
        ]
    )
]