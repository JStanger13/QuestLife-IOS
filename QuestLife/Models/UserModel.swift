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

    override static func primaryKey() -> String? {
        return "userID"
    }
    
    convenience init(userName: String, userClass: String) {
        self.init()

        self.userName = userName
        self.userClass = userClass
    }

}
