//
//  MainNavigationController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/12/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift

class MainNavigationController: UINavigationController {
    var users : Results <UserModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let realm = RealmService.shared.realm
        users = realm.objects(UserModel.self)
        print(String(users.count))
        
        //let isLoggedIn = true
        
        if !users.isEmpty {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.00)

        }
    }

    @objc func showLoginController(){
        let loginController = PageViewController()
        present(loginController, animated: true, completion: {
            
        })
    }
}


