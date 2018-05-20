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
    @objc var sideTitle: String!

    
    @objc dynamic var sideQuestID = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "sideQuestID"
    }
    
    convenience init(title: String) {
        self.init()
        self.sideTitle = title
    }
}
