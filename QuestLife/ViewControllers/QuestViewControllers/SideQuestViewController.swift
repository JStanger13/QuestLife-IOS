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

    var screenEffect: UIVisualEffect?
    var mainQuest: MainQuestModel?

    @IBOutlet weak var bossNameLabel: UILabel!
    @IBOutlet weak var mainQuestSideLabel: UILabel!
    @IBOutlet weak var sideBossImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet var addPopUpView: UIView!
    @IBOutlet weak var popuptTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
        
        if let effect = visualEffect.effect {
            screenEffect = effect
        }else{
            screenEffect = UIVisualEffect()
        }
        
        mainQuest = Singleton.sharedInstance.mainQuest
        mainQuestSideLabel.text = mainQuest?.mainTitle
        sideBossImage.image = UIImage(named: (mainQuest?.mainBoss)!)
        bossNameLabel.text = mainQuest?.mainBoss
        self.sideQuestList = RealmService.shared.getObjetcs(type: SideQuestModel.self)

    
    }
    func backAnimate(){
        UIView.animate(withDuration: 0.4, animations: {
            self.addPopUpView.alpha = 0
            self.visualEffect.effect = nil
            
        }) {(status) in
            self.addPopUpView.removeFromSuperview()
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
     backAnimate()
    }
   
    
    
    @IBAction func submitSideQuestTapped(_ sender: Any) {
        
        RealmService.shared.saveObjects(obj: [SideQuestModel(title: popuptTextField.text!)])

        backAnimate()
        self.collectionView.reloadData()
        self.popuptTextField.text = ""
    }
    
    @IBAction func createButton(_ sender: Any) {
                let mainQuest = MainQuestModel(title: textField.text!, boss: boss!, date: " ")
                RealmService.shared.saveObjects(obj: [mainQuest])
        
                let mainQuest = MainQuestModel(title: textField.text!, boss: boss!, date: "No Date ", time: "No Time")
                let mTitle = mainQuest.mainTitle
                let mBoss = mainQuest.mainBoss
                let mDate = mainQuest.mainDate
                let mTime = mainQuest.mainTime
                let mKey = mainQuest.mainQuestID
            
                RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime!, key: mKey)])
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.sideQuestList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SideQuestCell", for: indexPath) as? SideQuestCell else { return UICollectionViewCell() }
        let sideQuest = self.sideQuestList[indexPath.row]
        cell.Configure(with: sideQuest as! SideQuestModel)
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
