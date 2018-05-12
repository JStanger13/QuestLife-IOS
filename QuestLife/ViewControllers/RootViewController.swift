//
//  RootViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift

class RootViewController: UIViewController {
    var users : Results <UserModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        users = realm.objects(UserModel.self)
        
        
            print(String(users.count))
        
        

    }

    @IBAction func loadRealm(_ sender: Any) {
        Singleton.sharedInstance.user = users[0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
