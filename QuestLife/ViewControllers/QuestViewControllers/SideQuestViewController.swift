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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var mainQuest: MainQuestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainQuest = Singleton.sharedInstance.mainQuest
        mainQuestSideLabel.text = mainQuest?.mainTitle
        sideBossImage.image = UIImage(named: (mainQuest?.mainBoss)!)
        bossNameLabel.text = mainQuest?.mainBoss
    
        self.sideQuestList = RealmService.shared.getFilteredObjetcs(type: SideQuestModel.self, key: (mainQuest?.mainQuestID)!)
    }
    
    @IBAction func addSideQuest(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Second Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            RealmService.shared.saveObjects(obj: [SideQuestModel(title: firstTextField.text!, key: (self.mainQuest?.mainQuestID)!)])
       
            self.collectionView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
    
}
