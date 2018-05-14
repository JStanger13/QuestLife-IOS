//
//  BossService.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import UIKit
class BossService {
    
    private init() {}
    static var currentMainQuest: MainQuestModel?
    
    static func generateBoss(num: Int) -> String{
        
        var bossName: String = " "
        
        switch num {
        case 0:
            bossName = "Alien"
            break
        case 1:
            bossName = "Cerberus"
            break
        case 2:
            bossName = "Chimera"
            break
        case 3:
            bossName = "Cyclops"
            break
        case 4:
            bossName = "Devil"
            break
        case 5:
            bossName = "Dinosaur"
            break
        case 6:
            bossName = "Dragon"
            break
        case 7:
            bossName = "Echidna"
            break
        case 8:
            bossName = "Frankenstein"
            break
        case 9:
            bossName = "Goblin"
            break
        case 10:
            bossName = "Ghost"
            break
        case 11:
            bossName = "Hydra"
            break
        case 12:
            bossName = "Karakasakozou"
            break
        case 13:
            bossName = "Kraken"
            break
        case 14:
            bossName = "Loch-Ness-Monster"
            break
        case 15:
            bossName = "Medusa"
            break
        case 16:
            bossName = "Minotaur"
            break
        case 17:
            bossName = "Phoenix"
            break
        case 18:
            bossName = "Pirate"
            break
        case 19:
            bossName = "Robot"
            break
        case 20:
            bossName = "Vampire"
            break
        case 21:
            bossName = "Warewolf"
            break
        case 22:
            bossName = "Witch"
            break
        case 23:
            bossName = "Yeti"
            break
        case 24:
            bossName = "Zombie"
            break
        case 25:
            bossName = "loch-ness-monster"
            break
        default:
            break
        }
        return bossName
    }
}
