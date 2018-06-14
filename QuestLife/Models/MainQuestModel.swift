//
//  MainQuestModel.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import RealmSwift

class MainQuestModel: Object {
    @objc dynamic var mainTitle = ""
    @objc dynamic var mainBoss = ""
    @objc dynamic var mainDate = ""
    @objc dynamic var mainTime = ""
    @objc dynamic var mainSize = 0
    @objc dynamic var sideQuestsComplete = "0"


    @objc dynamic var mainQuestID = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "mainQuestID"
    }

    convenience init(title: String, boss: String, date: String, time: String) {
        self.init()
        self.mainTitle = title
        self.mainBoss = boss
        self.mainDate = date
        self.mainTime = time
        self.mainSize = 0
    }
    
    convenience init(title: String, boss: String, date: String, time: String, key: String) {
        self.init()
        self.mainTitle = title
        self.mainBoss = boss
        self.mainDate = date
        self.mainTime = time
        self.mainQuestID = key
        self.mainSize = 0
    }
    
    convenience init(title: String, boss: String, date: String, time: String, key: String, size: Int) {
        self.init()
        self.mainTitle = title
        self.mainBoss = boss
        self.mainDate = date
        self.mainTime = time
        self.mainQuestID = key
        self.mainSize = size
    }
}
