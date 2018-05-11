//
//  UserModel.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation

class UserModel {
    var userClass: String?
    var userName: String?
    convenience init(userName: String, userClass: String) {
        self.init()

        self.userName = userName
        self.userClass = userClass
    }
}
