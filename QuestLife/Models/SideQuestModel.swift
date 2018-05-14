//
//  SideQuestModel.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import RealmSwift

class SideQuestModel : Object{
    @objc dynamic var sideTitle : String?
    
    convenience init(title: String) {
        self.init()
        self.sideTitle = title
    }
}
