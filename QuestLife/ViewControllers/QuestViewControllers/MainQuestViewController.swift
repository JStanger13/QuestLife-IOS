//
//  MainQuestViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar


class MainQuestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDataSource, FSCalendarDelegate {
    
    var currentIndex: Int?
    @IBOutlet weak var dimView: UIView!
    @IBOutlet var timePopupView: UIView!
    @IBOutlet var deletePopupView: UIView!

    @IBOutlet weak var timeViewTransparentWhite: UIView!
    @IBOutlet weak var deleteViewTransparentWhite: UIView!
    @IBOutlet weak var datePopUpViewTransparentWhite: UIView!
    
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var timeSetButton: UIButton!
    @IBOutlet weak var timeBackButton: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarIcon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var setDateButton: UIButton!

    
    //Create Main Quest PopupView
    @IBOutlet var createMainQuestPopupView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bossImage: UIImageView!
    @IBOutlet weak var bossLabel: UILabel!
    
    var boss: String?
    var currentDate: String?

    
    @IBOutlet weak var userProgressBar: UIProgressView!
    
    @IBOutlet weak var datePopUpView: UIView!
    
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
        self.navigationItem.title = "MainQuests"
       
    

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "CloisterBlack-Light", size: 30.0)!, NSAttributedStringKey.foregroundColor: UIColor.white]

        
        UITabBar.appearance().shadowImage = UIImage(named: "cobblestone_bar")
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().layer.borderWidth = 0.50
        UITabBar.appearance().clipsToBounds = true
        
        self.mainQuestList = RealmService.shared.getObjetcs(type: MainQuestModel.self)
        self.collectionView.reloadData()
        let userClassString = user?.userClass
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        userNameLabel.text = user?.userName
        self.lvlLabel.text = "Level: \(user!.lvlString())"

        self.userProgressBar.progress = (user?.getPercent())!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        self.lvlLabel.text = "Level: \(user!.lvlString())"
        self.userProgressBar.progress = (user?.getPercent())!
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sideQuestSegue" {
            if let childViewController = segue.destination as? SideQuestViewController {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = getDate(date: date)
        self.setDateButton.isHidden = false
    }
    
    
    @IBAction func addMainQuestButton(_ sender: Any) {
        self.boss = BossService.generateBoss(num: Int(arc4random_uniform(26)))
        bossImage.image = UIImage(named: boss!)
        bossLabel.text = boss!
        
        createMainQuestPopupView.center = view.center
        createMainQuestPopupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(createMainQuestPopupView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0.8
            self.createMainQuestPopupView.transform = .identity
        })
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.8
            //self.deletePopupView.transform = .identity
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.createMainQuestPopupView.removeFromSuperview()
            self.timePopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.timePopupView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    @IBAction func backDateButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.datePopUpView.removeFromSuperview()
            self.datePopUpView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.datePopUpView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    @IBAction func deleteNo(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.deletePopupView.removeFromSuperview()
            self.timePopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.timePopupView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    @IBAction func deleteYes(_ sender: Any) {
       
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.deletePopupView.removeFromSuperview()
            self.timePopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.timePopupView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
        
        let item = mainQuestList[currentIndex!]
        RealmService.shared.deleteObjects(obj: [item])
        collectionView.reloadData()
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: textField.text!, boss: boss!, date: "No Date ", time: "No Time")])
        
        self.collectionView.reloadData()
        //self.dimView.alpha = 0
        self.createMainQuestPopupView.removeFromSuperview()
        self.textField.text = ""
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    @IBAction func timeBack(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.timePopupView.removeFromSuperview()
            self.timePopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.timePopupView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    @IBAction func timeSet(_ sender: Any) {
        
        let mTitle = self.currentMain?.mainTitle
        let mBoss = self.currentMain?.mainBoss
        let mDate = self.currentMain?.mainDate
        let mTime = getTime(date: self.timePicker.date)
        let mKey = self.currentMain?.mainQuestID
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime, key: mKey!)])
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.timePopupView.removeFromSuperview()
            self.timePopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.timePopupView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
        
        self.collectionView.reloadData()
    }
    
    @IBAction func setDateButtonTapped(_ sender: Any) {
        let mTitle = self.currentMain?.mainTitle
        let mBoss = self.currentMain?.mainBoss
        let mDate = self.currentDate
        let mTime = self.currentMain?.mainTime
        let mKey = self.currentMain?.mainQuestID
        
        
    
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime!, key: mKey!)])
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.datePopUpView.removeFromSuperview()
            self.datePopUpView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.datePopUpView.removeFromSuperview()
        }
        self.collectionView.reloadData()
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    func getTime(date: Date) -> String{
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
    
    func getDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        setDateButton.isHidden = false
        return dateFormatter.string(from: date)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = mainQuestList[indexPath.row]
        
      
        Singleton.sharedInstance.mainQuest = item as? MainQuestModel
        Singleton.sharedInstance.row = indexPath.row
    }
  
    @objc func saveCurrentMainQuest(sender: UIButton){
        Singleton.sharedInstance.mainQuest =  mainQuestList[sender.tag] as? MainQuestModel
    }
    
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}


extension MainQuestViewController : MainQuestCellDelegate {
   
    func setDate(cell: MainQuestCell) {
       
        if let indexPath = collectionView?.indexPath(for: cell){
            currentMain = mainQuestList[indexPath.row] as! MainQuestModel
            datePopUpView.center = view.center
            datePopUpView.layer.cornerRadius = 10
            datePopUpView.layer.masksToBounds = true
            datePopUpViewTransparentWhite.layer.cornerRadius = 5
            datePopUpView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            view.addSubview(datePopUpView)
            self.setDateButton.isHidden = true

            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                //self.dimView.alpha = 0.8
                self.datePopUpView.transform = .identity
            })
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.dimView.alpha = 0.8
                //self.deletePopupView.transform = .identity
            })
        }
    }
    
    func setTime(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            currentMain = mainQuestList[indexPath.row] as! MainQuestModel
            timePopupView.center = view.center
            timePopupView.layer.cornerRadius = 10
            timePopupView.layer.masksToBounds = true
            timeViewTransparentWhite.layer.cornerRadius = 5
            timePopupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            view.addSubview(timePopupView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                //self.dimView.alpha = 0.8
                self.timePopupView.transform = .identity
            })
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.dimView.alpha = 0.8
                //self.deletePopupView.transform = .identity
            })
        }
    }
    
    func delete(cell: MainQuestCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            //currentMain = mainQuestList[indexPath.row] as! MainQuestModel
            currentIndex = indexPath.row
            deletePopupView.center = view.center
            deletePopupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            deletePopupView.layer.cornerRadius = 10
            deleteViewTransparentWhite.layer.masksToBounds = true
            deleteViewTransparentWhite.layer.cornerRadius = 5
            view.addSubview(deletePopupView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                //self.dimView.alpha = 0.8
                self.deletePopupView.transform = .identity
            })
            
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.dimView.alpha = 0.8
                //self.deletePopupView.transform = .identity
            })
            
        }
    }
}



