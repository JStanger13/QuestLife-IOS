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
import AVFoundation
import AudioToolbox.AudioServices

class MainQuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDataSource, FSCalendarDelegate {
    
    let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
    
    //Heptic Feedback
    let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium) //Do I need this?
    let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    //set up sound effects
    var soundEffect: AVAudioPlayer? //Do I Need This?

    @IBOutlet weak var deleteQuestLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
 
    //Main Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dimView: UIView!

    //Transparent White Views
    @IBOutlet weak var timeViewTransparentWhite: UIView!
    @IBOutlet weak var deleteViewTransparentWhite: UIView!
    @IBOutlet weak var levelUpTransparentWhite: UIView!
    @IBOutlet weak var datePopUpViewTransparentWhite: UIView!
    @IBOutlet weak var createMainQuestTransparentWhite: UIView!
    
    //PopupViews
    @IBOutlet var createMainQuestPopupView: UIView!
    @IBOutlet var timePopupView: UIView!
    @IBOutlet var deletePopupView: UIView!
    @IBOutlet var levelUpPopUpView: UIView!

    //Set Buttons
    @IBOutlet weak var timeSetButton: UIButton!
    @IBOutlet weak var timeBackButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!

    //User Info View
    @IBOutlet weak var userProgressBar: UIProgressView!
    @IBOutlet weak var datePopUpView: UIView!
    @IBOutlet weak var youHaveLeveledUpLabel: UILabel!
    @IBOutlet weak var bossImage: UIImageView!
    @IBOutlet weak var bossLabel: UILabel!
    @IBOutlet weak var lvlLabel: UILabel!
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var smallAvatarLvlUpImage: UIView!
    @IBOutlet weak var bigAvatarLvlUpImage: UIImageView!
    
    
    @IBOutlet var editDateView: UIView!
    @IBOutlet weak var editDateTransparentWhite: UIView!
    
    //Buttons
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var userClassLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarIcon: UIImageView!
    @IBOutlet weak var addQuestButton: UIButton!
    @IBOutlet weak var questSetButton: UIButton!
    
    //Vars
    var currentIndex: Int?
    var boss: String?
    var currentDate: String?
    var user : UserModel?
    var users : Results <UserModel>!
    var mainQuestList : Results<Object>!
    var reversedQuestList : Results<Object>!
    var currentMain : MainQuestModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PopUpViewService.setUpTextField(textField: textField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainQuestViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainQuestViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Set Up TableView style attributes
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.bounces = false
        
        //Get User Info
        loadFromRealm()
        setUpUserLabels()

        //Determines When To Launch "LEVEL UP" PopupView
        isLevelUp()
        
        //Set Up Nav Bar Style Attributes
        self.navigationItem.title = "MainQuests"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "CloisterBlack-Light", size: 30.0)!, NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    func setUpUserLabels(){
        self.lvlLabel.text = "Level: \(user!.lvlString())"
        self.userProgressBar.progress = (user?.getPercent())!
        self.percentLabel.text = "\((Int((user?.getPercent())! * 100)).description)%"
        let userClassString = user?.userClass
        avatarIcon.image = UIImage(named: userClassString!)
        userClassLabel.text = userClassString
        userNameLabel.text = user?.userName
        self.lvlLabel.text = "Level: \(user!.lvlString())"
        self.userProgressBar.progress = (user?.getPercent())!
    }
    
    func loadFromRealm(){
        let realm = RealmService.shared.realm
        users = realm.objects(UserModel.self)
        user = users[0]
        self.mainQuestList = RealmService.shared.getObjetcs(type: MainQuestModel.self)
    }
    
    //TableView Methods-------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainQuestCell", for: indexPath) as? MainQuestCell else { return UITableViewCell() }
        let mainQuest = mainQuestList.reversed()[indexPath.row]
        cell.Configure(with: mainQuest as! MainQuestModel)
        cell.delegate = self
    
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainQuestList == nil{
            return 0
        }else{
            return (mainQuestList.count)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = mainQuestList[(mainQuestList.count - indexPath.row) - 1]
        
        Singleton.sharedInstance.mainQuest = item as? MainQuestModel
        Singleton.sharedInstance.row = (mainQuestList.count - indexPath.row) - 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sideQuestSegue" {
            if segue.destination is SideQuestViewController {
                PopUpViewService.playSound(sound: "pop-sound.aiff")
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
    
    //Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2.8
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    
    //Launch Popup Views------------------------------------------------------------------------------------
        //Check If User Levels Up
    func isLevelUp(){
        if (user?.isLevelUp)!{
            launchLevelUpPopUpView()
        }else{
            //do nothing
        }
    }
    @IBOutlet weak var lvlUpAvatarImage: UIImageView!
    
    //Level Up PopUp View-------------------------------------------------------------------------------------
    func launchLevelUpPopUpView(){
        PopUpViewService.setUpPopUpView(popUpView: levelUpPopUpView, transparentePopUpView: createMainQuestTransparentWhite, mView: view, mDimView: dimView)
    self.bigAvatarLvlUpImage.image = UIImage(named: (self.user?.userClass!)!)
    self.lvlUpAvatarImage.image = UIImage(named: (self.user?.userClass!)!)
        bigAvatarLvlUpImage.isHidden = true

        //Make Into Method
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            AudioServicesPlaySystemSound(self.vibrate)
            
            PopUpViewService.playSound(sound: "level_up.mp3")
            self.lvlUpAvatarImage.image = UIImage(named: (self.user?.userClass!)!)
            self.lvlUpAvatarImage.blink()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.lvlUpAvatarImage.isHidden = true
                self.bigAvatarLvlUpImage.isHidden = false
            }
        }
        
        //Save User LevelUp Info
        RealmService.shared.saveObjects(obj: [UserModel(userName: (user?.userName)!, userClass: (user?.userClass)!, userLvl: (user?.userLvl)!, id: (user?.userID)!, num: (user?.levelUpNumerator)!, den: (user?.levelUpDenominator)!, isLevelUp: false)])
        
        //Setup View Attributes
        PopUpViewService.setUpPopUpView(popUpView: levelUpPopUpView, transparentePopUpView: levelUpTransparentWhite, mView: view, mDimView: dimView)
        
        //Tell User What Level They Have Reached
        self.youHaveLeveledUpLabel.text = "You have reached level \(user!.lvlString())."
    }
    
    
    //Add Main Qust PopUp View--------------------------------------------------------------------------------
    @IBAction func addMainQuestButton(_ sender: Any) {
        heavyImpactFeedbackGenerator.impactOccurred()

        //Generate A New Boss
        self.boss = BossService.generateBoss(num: Int(arc4random_uniform(26)))
        bossImage.image = UIImage(named: boss!)
        bossLabel.text = "Defeat the \(boss!)"
        
        //Set Up Pop-Up View
        PopUpViewService.setUpPopUpView(popUpView: createMainQuestPopupView, transparentePopUpView: createMainQuestTransparentWhite, mView: view, mDimView: dimView)
        
        PopUpViewService.setUpTextField(textField: textField)
        self.questSetButton.isHidden = true
        textField.addTarget(self, action: #selector(checkUserInputInTextField), for: .editingChanged)
    }
    
    
    //BackButtons------------------------------------------------------------------------------------------
    @IBAction func backLvlUpButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: levelUpPopUpView, mDimView: dimView)
    }
    
    @IBAction func backButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: createMainQuestPopupView, mDimView: dimView)
        PopUpViewService.setUpTextField(textField: textField)
    }
    
    @IBAction func backDateButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: datePopUpView, mDimView: dimView
        )
    }
    
    @IBAction func timeBack(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: timePopupView, mDimView: dimView
        )
    }
    
    @IBAction func deleteNo(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: deletePopupView, mDimView: dimView
        )
    }
    
    @IBAction func deleteYes(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: deletePopupView, mDimView: dimView)

        let item = mainQuestList[currentIndex!]
        RealmService.shared.deleteObjects(obj: [item])
        tableView.reloadData()
    }
    
    
    //Set Buttons------------------------------------------------------------------------------------------
    @IBAction func createButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: createMainQuestPopupView, mDimView: dimView)
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: textField.text!, boss: boss!, date: " ", time: " ")])
        
        self.tableView.reloadData()
        
        PopUpViewService.setUpTextField(textField: textField)
        
    }
    
    @IBAction func timeSet(_ sender: Any) {
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: (self.currentMain?.mainTitle)!, boss: (self.currentMain?.mainBoss)!, date:  (self.currentMain?.mainDate)!, time: getDate(date: self.timePicker.date, type: "time"), key: (self.currentMain?.mainQuestID)!)])
        print(getDate(date: self.timePicker.date, type: "time"))
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: timePopupView, mDimView: dimView)
    
        self.tableView.reloadData()
    }
    
    @IBAction func setDateButtonTapped(_ sender: Any) {
       
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: (self.currentMain?.mainTitle)!, boss: (self.currentMain?.mainBoss)!, date: currentDate!, time: (self.currentMain?.mainTime)!, key: (self.currentMain?.mainQuestID)!)])
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: datePopUpView, mDimView: dimView)
        self.tableView.reloadData()
        print("Set Button: \(String(describing: currentDate!))")

    }
    
    
    //Get Methods for Time & Date------------------------------------------------------------------------------
    
    //Condense Into One Method!!!!!!
   
   
    func getDate(date: Date, type: String) -> String{
        let dateFormatter = DateFormatter()

        if type.contains("time"){
            dateFormatter.dateFormat = "h mm a"
        } else {
            dateFormatter.dateFormat = "MM/dd/yyyy"
        }
        setDateButton.isHidden = false
        return dateFormatter.string(from: date)
    }
  

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = getDate(date: date, type: "date")
        print("Date: \(currentDate as Any)")
        PopUpViewService.playSound(sound: "pop-sound.aiff")
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
        lightImpactFeedbackGenerator.impactOccurred()

        if let indexPath = tableView?.indexPath(for: cell){
            
            currentMain = mainQuestList.reversed()[indexPath.row] as? MainQuestModel
            if (currentMain?.mainDate.trimmingCharacters(in: .whitespaces).isEmpty)!{
                PopUpViewService.setUpPopUpView(popUpView:datePopUpView , transparentePopUpView: datePopUpViewTransparentWhite, mView: view, mDimView: dimView)
                self.setDateButton.isHidden = true
            }else{
                cell.dateButtonImage.image = UIImage(named:"white_calendar")
                PopUpViewService.playSound(sound: "pop-sound.aiff")
                   RealmService.shared.saveObjects(obj: [MainQuestModel(title: (self.currentMain?.mainTitle)!, boss: (self.currentMain?.mainBoss)!, date: "", time: (self.currentMain?.mainTime)!, key: (self.currentMain?.mainQuestID)!)])
            }
        }
        tableView.reloadData()
    }
    
    func setTime(cell: MainQuestCell) {
        lightImpactFeedbackGenerator.impactOccurred()
        if let indexPath = tableView?.indexPath(for: cell){
            currentMain = mainQuestList.reversed()[indexPath.row] as? MainQuestModel
            if (currentMain?.mainTime.trimmingCharacters(in: .whitespaces).isEmpty)!{
                PopUpViewService.setUpPopUpView(popUpView:timePopupView, transparentePopUpView: timeViewTransparentWhite, mView: view, mDimView: dimView)
            }else{
                cell.timeButtonImage.image = UIImage(named:"white_calendar")
                PopUpViewService.playSound(sound: "pop-sound.aiff")
                RealmService.shared.saveObjects(obj: [MainQuestModel(title: (self.currentMain?.mainTitle)!, boss: (self.currentMain?.mainBoss)!, date: (self.currentMain?.mainDate)!, time: "", key: (self.currentMain?.mainQuestID)!)])
            }
        }
        tableView.reloadData()
    }
    
    func delete(cell: MainQuestCell) {
        if let indexPath = tableView?.indexPath(for: cell){
            lightImpactFeedbackGenerator.impactOccurred()

            let currentMain = mainQuestList.reversed()[indexPath.row] as? MainQuestModel
            var completedSideQuestList : Results<Object>!
            let verb: String!
            let still: String!
            var sideQuestList : Results<Object>!
            currentIndex = (mainQuestList.count - indexPath.row) - 1
            
            PopUpViewService.setUpPopUpView(popUpView: deletePopupView, transparentePopUpView: deleteViewTransparentWhite, mView: view, mDimView: dimView)

            sideQuestList = RealmService.shared.getFilteredObjetcs(type: SideQuestModel.self, key: (currentMain!.mainQuestID))
            
            completedSideQuestList = sideQuestList?.filter("isChecked == %@", true)
            
            let sideQuestsLeft = sideQuestList.count - completedSideQuestList.count
            if sideQuestsLeft == 0 {
                still = " "
            }else{
                still = " still "
            }
            if sideQuestsLeft == 1 {
                verb = "SideQuest"
            }else{
                verb = "SideQuests"
            }

            deleteQuestLabel.text = "Are you sure you want to delete this quest? You\(still!)have \(String(sideQuestsLeft)) \(verb!) left to complete!"
        }
    }
    
    @objc func checkUserInputInTextField(){
        PopUpViewService.animateFadeInView(viewIsHidden: (textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!, view: questSetButton)
    }
}

extension UIView{
    func blink() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.01, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
    
    func mainFadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
}




