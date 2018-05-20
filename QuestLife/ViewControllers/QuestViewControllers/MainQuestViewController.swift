//
//  MainQuestViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift

class MainQuestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarIcon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var uiRealm = (UIApplication.shared.delegate as! AppDelegate).uiRealm
    var user : UserModel?
    var users : Results <UserModel>!
    var mainQuestList : Results<Object>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        let realm = RealmService.shared.realm
        users = realm.objects(UserModel.self)
        user = users[0]
        
        //readTasksAndUpdateUI()
        //self.mainQuestList = RealmService.shared.getObjetcs(type: MainQuestModel.self)
        self.mainQuestList = RealmService.shared.getMainQuests(type: MainQuestModel.self)
        self.collectionView.reloadData()

        
        let userClassString = user?.userClass
        
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        
        userNameLabel.text = user?.userName
    }


    func readTasksAndUpdateUI(){
        self.mainQuestList = RealmService.shared.getMainQuests(type: MainQuestModel.self)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mainQuestList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainQuestCell", for: indexPath) as? MainQuestCell else { return UICollectionViewCell() }
        let mainQuest = mainQuestList[indexPath.row]
        cell.Configure(with: mainQuest as! MainQuestModel)
        cell.delegate = self
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = mainQuestList[indexPath.row]
        Singleton.sharedInstance.mainQuest = item as? MainQuestModel
        //print(Singleton.sharedInstance.mainQuest?.mainTitle)
     
    }
    
  
    @objc func saveCurrentMainQuest(sender: UIButton){
        Singleton.sharedInstance.mainQuest =  mainQuestList[sender.tag] as? MainQuestModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}
extension MainQuestViewController : MainQuestCellDelegate {
    func setDate(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            let item = mainQuestList[indexPath.row]
            Singleton.sharedInstance.mainQuest = item as? MainQuestModel
            //RealmService.shared.deleteObjects(obj: [item])
            //collectionView.reloadData()
        }
    }
    
    func setTime(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            let item = mainQuestList[indexPath.row]
            Singleton.sharedInstance.mainQuest = item as? MainQuestModel
        }
    }
    
  
    
    func delete(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            let item = mainQuestList[indexPath.row]
            RealmService.shared.deleteObjects(obj: [item])
            collectionView.reloadData()
        }
    }
}
