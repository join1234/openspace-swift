//
//  GameState.swift
//  Open Space
//
//  Created by Andy Triboletti on 2/21/20.
//  Copyright © 2020 GreenRobot LLC. All rights reserved.
//

import Foundation

class GameState {
    var shipNames:Array = ["Anderik", "Eleuz"]
    var currentShipName:String {
        let theName = shipNames[1]
        return theName
    }
    var currentShipModel:String = "spaceshipb.scn"
    var closestOtherPlayerShipModel:String = "space11.dae"
    var closestOtherPlayerShipName:String = "Centa"

}
