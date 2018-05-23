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
    
    @IBOutlet var timePopupView: UIView!
    
    @IBOutlet weak var timeSetButton: UIButton!
    @IBOutlet weak var timeBackButton: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarIcon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var user : UserModel?
    var users : Results <UserModel>!
    var mainQuestList : Results<Object>!
    var currentMain : MainQuestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        let realm = RealmService.shared.realm
        users = realm.objects(UserModel.self)
        user = users[0]
        
        self.mainQuestList = RealmService.shared.getObjetcs(type: MainQuestModel.self)
        self.collectionView.reloadData()
        let userClassString = user?.userClass
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        userNameLabel.text = user?.userName
    }
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    
    @IBAction func timeBack(_ sender: Any) {
        timePopupView.removeFromSuperview()
    }
    @IBAction func timeSet(_ sender: Any) {
        
        let mTitle = self.currentMain?.mainTitle
        let mBoss = self.currentMain?.mainBoss
        let mDate = self.currentMain?.mainDate
        let mTime = getDate(date: self.timePicker.date)
        let mKey = self.currentMain?.mainQuestID
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime, key: mKey!)])
        timePopupView.removeFromSuperview()
        self.collectionView.reloadData()
    }
    
    func getDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h mm a"
        return dateFormatter.string(from: date)
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
        
        let inst = Singleton.sharedInstance
        inst.mainQuest = item as! MainQuestModel
        Singleton.sharedInstance.mainQuest = item as? MainQuestModel
        Singleton.sharedInstance.row = indexPath.row
    }
  
    @objc func saveCurrentMainQuest(sender: UIButton){
        Singleton.sharedInstance.mainQuest =  mainQuestList[sender.tag] as? MainQuestModel
    }
    
}

extension MainQuestViewController : MainQuestCellDelegate {
   
    func setDate(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            var mainQuest: MainQuestModel?
            let item = mainQuestList[indexPath.row]
            mainQuest = item as? MainQuestModel
            Singleton.sharedInstance.mainQuest = mainQuest
            print(mainQuest?.mainTitle)
        }
    }
    
    func setTime(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            currentMain = mainQuestList[indexPath.row] as! MainQuestModel
            view.addSubview(timePopupView)
            timePopupView.center = view.center
            /*
            var mainQuest: MainQuestModel?
            let item = mainQuestList[indexPath.row]
            mainQuest = item as? MainQuestModel
            Singleton.sharedInstance.mainQuest = mainQuest
             */
            
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
