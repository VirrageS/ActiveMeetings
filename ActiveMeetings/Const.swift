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
        type: SportTypes.Bicycle,
        modes: [
            Mode(type: ModeTypes.Recreational),
            Mode(type: ModeTypes.Sporty),
            Mode(type: ModeTypes.Amateur),
            Mode(type: ModeTypes.Downhill)
        ]
    ),
    
    Sport(
        type: SportTypes.Football,
        modes: [
            Mode(type: ModeTypes.Amateur),
            Mode(type: ModeTypes.Sporty)
        ]
    ),
    
    Sport(
        type: SportTypes.Basketball,
        modes: [
            Mode(type: ModeTypes.Sporty),
            Mode(type: ModeTypes.Amateur)
        ]
    ),
    
    Sport(
        type: SportTypes.Rollers,
        modes: [
            Mode(type: ModeTypes.Sporty)
        ]
    )
]