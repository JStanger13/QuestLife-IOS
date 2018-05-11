//
//  MainQuestViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

class MainQuestViewController: UIViewController {

    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarIcon: UIImageView!
    
    var user : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Singleton.sharedInstance.user

        let userClassString = user?.userClass
        
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        
        userNameLabel.text = user?.userName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}
