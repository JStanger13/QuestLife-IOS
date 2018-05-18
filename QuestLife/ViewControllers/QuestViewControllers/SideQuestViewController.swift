//
//  SideQuestViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/12/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift

class SideQuestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var sideQuestList : Results<Object>!

   
    
    @IBOutlet weak var bossNameLabel: UILabel!
    
    @IBOutlet weak var mainQuestSideLabel: UILabel!
    @IBOutlet weak var sideBossImage: UIImageView!
    
    var mainQuest: MainQuestModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainQuest = Singleton.sharedInstance.mainQuest
        mainQuestSideLabel.text = mainQuest?.mainTitle
        sideBossImage.image = UIImage(named: (mainQuest?.mainBoss)!)
        bossNameLabel.text = mainQuest?.mainBoss
        self.sideQuestList = RealmService.shared.getObjetcs(type: SideQuestModel.self)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sideQuestList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SideQuestCell", for: indexPath) as? SideQuestCell else { return UICollectionViewCell() }
        let sideQuest = sideQuestList[indexPath.row]
        cell.Configure(with: sideQuest as! SideQuestModel)
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
