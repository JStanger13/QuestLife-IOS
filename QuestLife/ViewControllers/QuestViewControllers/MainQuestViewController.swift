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
    
    var user : UserModel?
    var users : Results <UserModel>!
    var mainQuestList : Results<Object>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = RealmService.shared.realm
        users = realm.objects(UserModel.self)
        user = users[0]
        
        self.mainQuestList = RealmService.shared.getObjetcs(type: MainQuestModel.self)
        
    
        
        let userClassString = user?.userClass
        
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        
        userNameLabel.text = user?.userName
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mainQuestList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainQuestCell", for: indexPath) as? MainQuestCell else { return UICollectionViewCell() }
        let mainQuest = mainQuestList[indexPath.row]
        cell.Configure(with: mainQuest as! MainQuestModel)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
}
