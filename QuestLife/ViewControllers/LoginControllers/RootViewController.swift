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
    var users : Results <Object>!
    
    @IBOutlet weak var toMainQuestButton: UIButton!
    
    @IBOutlet weak var toPagerViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let realm = RealmService.shared.realm
        users = RealmService.shared.getObjetcs(type: UserModel.self)
        print(String(users.count))
        
        if users.isEmpty{
            toMainQuestButton.isHidden = true
            toPagerViewButton.isHidden = false
        } else {
            toPagerViewButton.isHidden = true
            toMainQuestButton.isHidden = false

        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
