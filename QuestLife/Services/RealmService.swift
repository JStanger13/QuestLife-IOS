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
    }//</object></objects>
    /*
    func create<T: Object>(_ object: T){
        do {
            try realm.write {
                realm.add(object)
            }
        }catch{
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.objects(UserModel)[0].mainQuestList.append(<#T##object: MainQuestModel##MainQuestModel#>)
            }
            
        }catch{
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T){
        do {
            try realm.write {
                realm.delete(object)
                
            }
        }catch{
            post(error)
        }
        
    }
    
    func post(_ error: Error)  {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void)  {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"),
                                               object: nil,
                                               queue: nil) { (notification) in
                                                completion(notification.object as? Error)
                                                
        }
    }
    
    func stopObservingErrors(in vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
 */
}
