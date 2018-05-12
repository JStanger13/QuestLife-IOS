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
    
   
    convenience init(userName: String, userClass: String) {
        self.init()

        self.userName = userName
        self.userClass = userClass
    }
}
