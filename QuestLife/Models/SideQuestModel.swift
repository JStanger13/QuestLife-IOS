//
//  SideQuestModel.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import RealmSwift

class SideQuestModel: Object{
    @objc dynamic var sideTitle: String?
    @objc dynamic var mainKey: String?

    @objc dynamic var sideQuestID = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "sideQuestID"
    }
    
    convenience init(title: String, key: String) {
        self.init()
        self.sideTitle = title
        self.mainKey = key
    }
}
