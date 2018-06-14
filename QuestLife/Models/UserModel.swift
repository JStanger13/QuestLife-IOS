//
//  UserModel.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel : Object{
    @objc dynamic var userClass: String?
    @objc dynamic var userName: String?
    var mainQuestList = List<MainQuestModel>()
    @objc dynamic var userID = UUID().uuidString
    @objc dynamic var userLvl = 0
    @objc dynamic var levelUpNumerator = 0
    @objc dynamic var levelUpDenominator = 0
    @objc dynamic var isLevelUp = false

    
    func lvlString() -> String{
        return String(self.userLvl)
    }
    
    func getPercent()-> Float{
        if levelUpDenominator == 0{
            return Float(0)
        }
        return Float(Double(levelUpNumerator)/Double(levelUpDenominator))
    }
    
    override static func primaryKey() -> String? {
        return "userID"
    }

    convenience init(userName: String, userClass: String, userLvl: Int, num: Int, den: Int) {
        self.init()
        
        self.userName = userName
        self.userClass = userClass
        self.userLvl = userLvl
        self.levelUpNumerator = num
        self.levelUpDenominator = den
        self.isLevelUp = false
    }
    
    convenience init(userName: String, userClass: String, userLvl: Int, id: String, num: Int, den: Int) {
        self.init()
        
        self.userName = userName
        self.userClass = userClass
        self.userLvl = userLvl
        self.userID = id
        self.levelUpNumerator = num
        self.levelUpDenominator = den
        self.isLevelUp = false

    }
    
    convenience init(userName: String, userClass: String, userLvl: Int, id: String, num: Int, den: Int, isLevelUp: Bool) {
        self.init()
        
        self.userName = userName
        self.userClass = userClass
        self.userLvl = userLvl
        self.userID = id
        self.levelUpNumerator = num
        self.levelUpDenominator = den
        self.isLevelUp = isLevelUp
    }

}
