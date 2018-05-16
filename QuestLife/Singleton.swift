
//
//  Singleton.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
class Singleton{
    static let sharedInstance = Singleton()
    private init() {}
    var user : UserModel?
    
    var mainQuest : MainQuestModel?
}
