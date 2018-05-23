//
//  CreateMainQuestPopupViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/14/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift

class CreateMainQuestPopupViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bossImage: UIImageView!
    @IBOutlet weak var bossLabel: UILabel!
    var boss: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boss = BossService.generateBoss(num: Int(arc4random_uniform(26)))
        bossImage.image = UIImage(named: boss!)
        bossLabel.text = boss!
    }


    @IBAction func createButton(_ sender: Any) {
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: textField.text!, boss: boss!, date: "No Date ", time: "No Time")])
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
