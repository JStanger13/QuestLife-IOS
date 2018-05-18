//
//  MainQuestModel.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import RealmSwift

class MainQuestModel: Object{
    @objc dynamic var mainTitle: String?
    @objc dynamic var mainBoss: String?
    @objc dynamic var mainDate: String?
    @objc dynamic var mainTime: String?
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
    }
    
    convenience init(title: String, boss: String, date: String, time: String, key: String) {
        self.init()
        self.mainTitle = title
        self.mainBoss = boss
        self.mainDate = date
        self.mainTime = time
        self.mainQuestID = key
    }
}
