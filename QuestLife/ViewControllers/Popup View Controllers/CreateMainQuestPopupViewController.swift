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
    //var user : UserModel?
    //var users : Results <UserModel>!
    @IBOutlet weak var bossImage: UIImageView!
    @IBOutlet weak var bossLabel: UILabel!
    var boss: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boss = BossService.generateBoss(num: Int(arc4random_uniform(26)))
        bossImage.image = UIImage(named: boss!)
        bossLabel.text = boss!
       
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func createButton(_ sender: Any) {
        let mainQuest = MainQuestModel(title: textField.text!, boss: boss!, date: "No Date ", time: "No Time")
        let mTitle = mainQuest.mainTitle
        let mBoss = mainQuest.mainBoss
        let mDate = mainQuest.mainDate
        let mTime = mainQuest.mainTime
        let mKey = mainQuest.mainQuestID

        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime!, key: mKey)])
        
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
