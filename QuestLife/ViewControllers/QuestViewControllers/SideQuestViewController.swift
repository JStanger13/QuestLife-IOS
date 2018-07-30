//
//  SideQuestViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/12/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation
import AudioToolbox.AudioServices

class SideQuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var navBar: UINavigationBar = UINavigationBar()
    var playSlashSound = false

    //Outlets
    //Main Outlets
    @IBOutlet weak var bossNameLabel: UILabel!
    @IBOutlet weak var mainQuestSideLabel: UILabel!
    @IBOutlet weak var sideBossImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var missionCompleteViewTransparentWhite: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var completedNumberLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var deleteSideQuestView: UIView!
    @IBOutlet weak var deleteSideQuestViewTransparentWhite: UIView!

    //Quest Complete Outlets
    @IBOutlet weak var slayedBossImage: UIImageView!
    
    //Add Side Quest Outles
    @IBOutlet var addSideQuestView: UIView!
    @IBOutlet weak var addSideTransparentWhite: UIView!
    @IBOutlet weak var textView: UITextField!
    @IBOutlet var missionCompleteView: UIView!
    
    //Edit View
    
    @IBOutlet weak var editSaveButtonOutlet: UIButton!
    @IBOutlet var editView: UIView!
    
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    
    //Vars
    let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
    var mainQuest: MainQuestModel?
    var sideQuestList : Results<Object>!
    var completedSideQuestList : Results<Object>!
    var users : Results <Object>!
    var user : UserModel?
    var soundEffect: AVAudioPlayer?
    var currentSide : SideQuestModel?

    
    @IBOutlet weak var okayButtonOutlet: UIButton!
    @IBOutlet weak var deleteQuestLabel: UILabel!
    @IBOutlet weak var saveQuestButton: UIButton!
    
    
    
    @IBOutlet weak var editViewTransparentWhite: UIView!
    
    
    
    //Functions------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //rename to TextField
        
        NotificationCenter.default.addObserver(self, selector: #selector(SideQuestViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SideQuestViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        tableView.bounces = false
        
        //mainQuest = Singleton.sharedInstance.mainQuest
        mainQuestSideLabel.text = "\(mainQuest?.mainTitle ?? "-")"
        sideBossImage.image = UIImage(named: (mainQuest?.mainBoss)!)
        bossNameLabel.text = "\(mainQuest?.mainBoss ?? "-")"
        
        getBossHealth()
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            PopUpViewService.playSound(sound: "pop-sound.aiff")
            PopUpViewService.hepticFeedback(type: "light")
        }
    }
    
    //TableView-----------------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sideQuestList == nil{
            return 0
        }else{
            return (sideQuestList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideQuestCell", for: indexPath) as? SideQuestCell else { return UITableViewCell() }
        let sideQuest = sideQuestList[indexPath.row]
        cell.Configure(with: sideQuest as! SideQuestModel)
        
        setUpViewAnimations(cell: cell)
        
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        cell.delegate = self
        cell.selectionStyle = .none

        return cell
    }
    
    
    //Set Up Helper Functions----------------------------------------------------------------------------------
   
    func loadLists(){
        self.sideQuestList = RealmService.shared.getFilteredObjetcs(type: SideQuestModel.self, key: (mainQuest?.mainQuestID)!)
        self.sizeLabel.text = "SideQuests Available: \(String(sideQuestList.count))"
        let results = RealmService.shared.getFilteredObjetcs(type: SideQuestModel.self, key: (mainQuest?.mainQuestID)!)
        self.sideQuestList = results
        self.completedSideQuestList = results?.filter("isChecked == %@", true)
        self.completedNumberLabel.text = "Number Completed: \(String(completedSideQuestList.count))"
    }
    
    func getBossHealth(){
        loadLists()
        let progressValue: Double = Double(1) - Double(completedSideQuestList.count)/Double(sideQuestList.count)
        print(String(progressValue))
        self.progressView.setProgress(Float(progressValue), animated: true)
        missionComplete()
    }

    func setUpViewAnimations(cell: SideQuestCell ){
        PopUpViewService.animateFadeInView(viewIsHidden: cell.checkBox.isChecked, view: cell.whiteGarbageView)
        PopUpViewService.animateFadeInView(viewIsHidden: cell.checkBox.isChecked, view: cell.whiteEditView)
    }
    
    func missionComplete(){
        if self.progressView.progress == 0.0{
            
            //Set Up Vibration
            AudioServicesPlaySystemSound(self.vibrate)
            
            //Set Up Sounds
            //PopUpViewService.playSound(sound: "bounce-sound.aiff")
            
            //Set Up Views
            let boss: String! = mainQuest?.mainBoss
            self.slayedBossImage.image = UIImage(named: boss)
            //self.sideBossImage.image = UIImage(named: "rip")
            
            missionCompleteView.center = view.center
            missionCompleteView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            
            //Set Up Animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                PopUpViewService.playSound(sound: "enemy-destroyed.wav")
                self.slayedBossImage.animationImages = ([UIImage(named: "Red\(boss!)"), UIImage(named: "Black\(boss!)"),UIImage(named: "Red\(boss!)"), UIImage(named: "Black\(boss!)"), UIImage(named: "Red\(boss!)"), UIImage(named: "Black\(boss!)")] as! [UIImage])
                //self.slayedBossImage.animationDuration = 1.0
                self.slayedBossImage.startAnimating()
                self.slayedBossImage.fadeOut()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                PopUpViewService.setUpPopUpView(popUpView: self.missionCompleteView, transparentePopUpView: self.missionCompleteViewTransparentWhite, mView: self.view, mDimView: self.dimView)
            }
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.okayButtonOutlet.fadeIn()
            }
            users = RealmService.shared.getObjetcs(type: UserModel.self)
            user = users[0] as? UserModel
            
            checkLevelUpProgress()
        }
    }
    
    func checkLevelUpProgress(){
        var mNumerator = (user?.levelUpNumerator)! + 1
        var mDenominator = user?.levelUpDenominator
        var mLvl = user?.userLvl
        var isLvlUp = false
        if mNumerator == mDenominator{
            mLvl = mLvl! + 1
            mNumerator = 0
            mDenominator = mLvl! * 2
            isLvlUp = true
        }
        RealmService.shared.saveObjects(obj: [UserModel(userName: (user?.userName)!, userClass: (user?.userClass)!, userLvl: mLvl!, id: (user?.userID)!, num: (mNumerator), den: (mDenominator)!, isLevelUp: (isLvlUp))])
    }
    
    func animateBoss(boss: String, color: String){
        self.sideBossImage.animationImages = ([UIImage(named: "\(color)\(boss)"), UIImage(named: "Black\(boss)"),UIImage(named: "\(color)\(boss)"), UIImage(named: "Black\(boss)"), UIImage(named: "\(color)\(boss)"), UIImage(named: "Black\(boss)")] as! [UIImage])
        self.sideBossImage.animationDuration = 0.5
        self.sideBossImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sideBossImage.stopAnimating()
        }
    }
    
    @objc func cancelTapped (){
        PopUpViewService.hepticFeedback(type: "light")
        PopUpViewService.playSound(sound: "pop_sound.aiff")
    }
    
    //Keyboard--------------------------------------------------------------------------------------------
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
    
    let date = Date().addingTimeInterval(5)
    
    //Button Actions--------------------------------------------------------------------------------------------
    @IBAction func addSideQuest(_ sender: Any) {
        PopUpViewService.setUpTextField(textField: textView)
        PopUpViewService.setUpPopUpView(popUpView: addSideQuestView, transparentePopUpView: addSideTransparentWhite, mView: view, mDimView: dimView)
        
        heavyImpactFeedbackGenerator.impactOccurred()
        
        self.saveQuestButton.isHidden = true//Do I Need This?
        textView.addTarget(self, action: #selector(checkUserInputInTextField), for: .editingChanged)
    }
    
 
    
    
    //Back Buttons----------------------------------------------------------------------------------------------
    @IBAction func okayButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: missionCompleteView, mDimView: dimView)
        let item = mainQuest
        RealmService.shared.deleteObjects(obj: [item!])
    }
  
    @IBAction func editViewBackButtonAction(_ sender: Any) {
        editSaveButtonOutlet.alpha = 0.0
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: editView, mDimView: dimView)
        
    }
    
    //Fix
    @IBAction func editAveButtonSetAction(_ sender: Any) {
        RealmService.shared.saveObjects(obj: [SideQuestModel(title: (editTextField.text)!, key: (currentSide?.mainKey)!, id: (currentSide?.sideQuestID)! , checked: (currentSide?.isChecked)!)])
        
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: editView, mDimView: dimView)
        tableView.reloadData()
    }
    
    @IBAction func submitSideQuestButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: addSideQuestView, mDimView: dimView)
        RealmService.shared.saveObjects(obj: [SideQuestModel(title: textView.text!, key: (self.mainQuest?.mainQuestID)!)])
        self.tableView.reloadData()
        PopUpViewService.setUpTextField(textField: textView)
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: (mainQuest?.mainTitle)!, boss: (mainQuest?.mainBoss)!, date: (mainQuest?.mainDate)!, time: (mainQuest?.mainTime)!, key: (mainQuest?.mainQuestID)!, size: (self.mainQuest?.mainSize)! + 1)])
        self.sizeLabel.text = ("SideQuests Available: \(String(sideQuestList.count))")
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: addSideQuestView, mDimView: dimView)
        PopUpViewService.setUpTextField(textField: textView)
    }
    
    @IBAction func deleteQuestBackButtonAction(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: deleteSideQuestView, mDimView: dimView)
    }
    
    @IBAction func deleteQuestSetButtonAction(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: deleteSideQuestView, mDimView: dimView)
        RealmService.shared.deleteObjects(obj: [currentSide!])
        getBossHealth()
        tableView.reloadData()
        if playSlashSound == true{
            PopUpViewService.playSound(sound: "slash.wav")
        }   
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        let sideQuest: SideQuestModel = (sideQuestList[sender.tag] as? SideQuestModel)!
        if sender.isChecked{
            PopUpViewService.playSound(sound: "slash.wav")
            animateBoss(boss: (mainQuest?.mainBoss)!, color: "Red")

            RealmService.shared.saveObjects(obj: [SideQuestModel(title: sideQuest.sideTitle!, key: sideQuest.mainKey!, id: sideQuest.sideQuestID, checked: true)])
        } else {
            PopUpViewService.playSound(sound: "heal-sound.wav")
            animateBoss(boss:  (mainQuest?.mainBoss)!, color: "Green")
           
            RealmService.shared.saveObjects(obj: [SideQuestModel(title: sideQuest.sideTitle!, key: sideQuest.mainKey!, id: sideQuest.sideQuestID, checked: false)])
        }
        tableView.reloadData()
        getBossHealth()
    }

    @objc func checkUserInputInTextField(){
        PopUpViewService.animateFadeInView(viewIsHidden: (textView.text?.trimmingCharacters(in: .whitespaces).isEmpty)!, view: saveQuestButton)
    }
    @objc func checkEditViewUserInputInTextField(){
        PopUpViewService.animateFadeInView(viewIsHidden: (editTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!, view: editSaveButtonOutlet)
    }
}
//Extentions--------------------------------------------------------------------------------------------------
extension SideQuestViewController : SideQuestCellDelegate {
    func edit(cell: SideQuestCell) {
        PopUpViewService.setUpTextField(textField: editTextField)
        PopUpViewService.hepticFeedback(type: "medium")

        if let indexPath = tableView?.indexPath(for: cell){
            currentSide = sideQuestList[indexPath.row] as? SideQuestModel
            editLabel.text = currentSide!.sideTitle!
              PopUpViewService.setUpPopUpView(popUpView: editView, transparentePopUpView: editViewTransparentWhite, mView: view, mDimView: dimView)
            PopUpViewService.setUpTextField(textField: editTextField)
            self.editTextField.addTarget(self, action: #selector(checkEditViewUserInputInTextField), for: .editingChanged)
        }
    }
    
    func delete(cell: SideQuestCell) {
        PopUpViewService.hepticFeedback(type: "medium")

        if let indexPath = tableView?.indexPath(for: cell){
            let deleteMessage = "Are you sure you want to delete this SideQuest?"
            
            if (sideQuestList.count - completedSideQuestList.count) == 1 && completedSideQuestList.count > 0 {
                playSlashSound = true
                deleteQuestLabel.text = "\(deleteMessage) Deleting this item on your list will complete your Quest and defeat the \((mainQuest?.mainBoss)!)!"
            } else {
                 deleteQuestLabel.text = deleteMessage
            }
            currentSide = sideQuestList[indexPath.row] as? SideQuestModel
            PopUpViewService.setUpPopUpView(popUpView: deleteSideQuestView, transparentePopUpView: deleteSideQuestViewTransparentWhite, mView: view, mDimView: dimView)
        }
    }
}

extension UIProgressView {
    func animate(duration: Double) {
        setProgress(0.01, animated: true)
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            self.setProgress(1.0, animated: true)
        }, completion: nil)
    }
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 1.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
