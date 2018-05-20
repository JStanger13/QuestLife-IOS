//
//  RealmService.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService{
    private init() {}
    static let shared = RealmService()
    var realm = try! Realm()
    
    func saveObjects(obj: [Object]){
        try! realm.write {
            realm.add(obj, update: true)
        }
    }
    
    func getObjetcs(type: Object.Type) -> Results<Object>?{
        return realm.objects(type)
    }
    
    func getFilteredObjetcs(type: Object.Type, key: String) -> Results<Object>? {
        let predicate = NSPredicate(format: "mainKey == %@", key)
        return realm.objects(type)
    }
    
    func deleteObjects(obj: [Object]){
        try! realm.write {
            realm.delete(obj)
        }
    }
}
