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
    var completedSideQuestList : Results<Object>!
    var users : Results <Object>!
    var user : UserModel?

    @IBOutlet weak var dimView: UIView!

    @IBOutlet weak var completedNumberLabel: UILabel!
    @IBOutlet weak var textView: UITextField!
    @IBOutlet var addSideQuestView: UIView!
    
    @IBOutlet var missionCompleteView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var bossNameLabel: UILabel!
    @IBOutlet weak var mainQuestSideLabel: UILabel!
    @IBOutlet weak var sideBossImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var missionCompleteViewTransparentWhite: UIView!

    
    var mainQuest: MainQuestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    


        mainQuest = Singleton.sharedInstance.mainQuest
        
        mainQuestSideLabel.text = mainQuest?.mainTitle
        sideBossImage.image = UIImage(named: (mainQuest?.mainBoss)!)
        bossNameLabel.text = mainQuest?.mainBoss
        
        getBossHealth()
    }
    
    func loadLists(){
        self.sideQuestList = RealmService.shared.getFilteredObjetcs(type: SideQuestModel.self, key: (mainQuest?.mainQuestID)!)
        self.sizeLabel.text = String(sideQuestList.count)
        
        let results = RealmService.shared.getFilteredObjetcs(type: SideQuestModel.self, key: (mainQuest?.mainQuestID)!)
        self.sideQuestList = results
        self.completedSideQuestList = results?.filter("isChecked == %@", true)
        self.completedNumberLabel.text = String(completedSideQuestList.count)
    }
    
    func getBossHealth(){
        loadLists()
        let progressValue: Double = Double(1) - Double(completedSideQuestList.count)/Double(sideQuestList.count)
        print(String(progressValue))
        self.progressView.progress = Float(progressValue)
        missionComplete()
    }
    
    func missionComplete(){
        if self.progressView.progress == 0.0{
            missionCompleteView.center = view.center
            missionCompleteView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            view.addSubview(missionCompleteView)
            users = RealmService.shared.getObjetcs(type: UserModel.self)
            user = users[0] as? UserModel
            print("num =\(String(describing: user?.levelUpNumerator))")
            
            var mNumerator = (user?.levelUpNumerator)! + 1
            var mDenominator = user?.levelUpDenominator
            var mLvl = user?.userLvl
            
            if mNumerator == mDenominator{
                mLvl = mLvl! + 1
                mNumerator = 0
                mDenominator = mLvl! * 2
            }
            
            RealmService.shared.saveObjects(obj: [UserModel(userName: (user?.userName)!, userClass: (user?.userClass)!, userLvl: mLvl!, id: (user?.userID)!, num: (mNumerator), den: (mDenominator)!)])
            
            missionCompleteView.layer.cornerRadius = 10
            missionCompleteView.layer.masksToBounds = true
            missionCompleteViewTransparentWhite.layer.cornerRadius = 5
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                //self.dimView.alpha = 0.8
                self.missionCompleteView.transform = .identity
                let results = RealmService.shared.getFilteredMain(type: MainQuestModel.self, key: (self.mainQuest?.mainQuestID)!)
                RealmService.shared.deleteObjects(obj: [results![0]])
            })
        }
    }
    
    
    @IBAction func okayButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.missionCompleteView.removeFromSuperview()
        }){(success) in
            //self.timePopupView.removeFromSuperview()
        }
    }
    
    @IBAction func submitSideQuestButton(_ sender: Any) {
        RealmService.shared.saveObjects(obj: [SideQuestModel(title: textView.text!, key: (self.mainQuest?.mainQuestID)!)])
        self.collectionView.reloadData()
        //self.dimView.alpha = 0
        self.addSideQuestView.removeFromSuperview()
        textView.text = ""
        
        let mTitle = self.mainQuest?.mainTitle
        let mBoss = self.mainQuest?.mainBoss
        let mDate = self.mainQuest?.mainDate
        let mTime = self.mainQuest?.mainTime
        let mKey = self.mainQuest?.mainQuestID
        
        
        
        let mSize = (self.mainQuest?.mainSize)! + 1
         
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime!, key: mKey!, size: mSize)])
        self.sizeLabel.text = String(sideQuestList.count)

    }
    
    
    @IBAction func addSideQuest(_ sender: Any) {
        
        addSideQuestView.center = view.center
        addSideQuestView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(addSideQuestView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0.8
            self.addSideQuestView.transform = .identity
        })
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.addSideQuestView.removeFromSuperview()
            //self.timePopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            //self.timePopupView.removeFromSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sideQuestList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SideQuestCell", for: indexPath) as? SideQuestCell else { return UICollectionViewCell() }
        let sideQuest = sideQuestList[indexPath.row]
        cell.Configure(with: sideQuest as! SideQuestModel)
        if cell.checkBox.isChecked{
            cell.sideQuestDeleteButton.isHidden = true
        } else{
              cell.sideQuestDeleteButton.isHidden = false
        }
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        cell.delegate = self

        return cell
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        let sideQuest: SideQuestModel = (sideQuestList[sender.tag] as? SideQuestModel)!
        let title = sideQuest.sideTitle
        let key = sideQuest.mainKey
        let id = sideQuest.sideQuestID
        
        if sender.isChecked{
            RealmService.shared.saveObjects(obj: [SideQuestModel(title: title!, key: key!, id: id, checked: true)])
        
        } else {
            RealmService.shared.saveObjects(obj: [SideQuestModel(title: title!, key: key!, id: id, checked: false)])
        }
        collectionView.reloadData()
        getBossHealth()
    }

}

extension SideQuestViewController : SideQuestCellDelegate {
    func delete(cell: SideQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            let item = sideQuestList[indexPath.row]
            RealmService.shared.deleteObjects(obj: [item])
            collectionView.reloadData()
        }
    }
}
