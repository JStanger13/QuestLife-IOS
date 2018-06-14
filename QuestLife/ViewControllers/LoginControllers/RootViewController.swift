//
//  RootViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//


import UIKit
import RealmSwift
import AVFoundation

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   //vars
    let avatars = ["Knight", "Viking", "Gnome", "Girl-Elf", "Boy-Elf", "Prince", "Wizard", "Princess", "Fairy"]
    var users : Results <Object>!
    var quests: Results<Object>!
    var mName: String?
    var mClass: String?
    var soundEffect: AVAudioPlayer?

    //Views
    @IBOutlet var nameCreatorView: UIView!
    @IBOutlet var characterSelectorView: UIView!

    //HomeView
    @IBOutlet weak var firstTimeView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!

    //WelcomeBack
    @IBOutlet weak var homeAvatarIView: UIImageView! //ReName
    @IBOutlet weak var welcomeBackView: UIView!
    @IBOutlet weak var toMainQuestButton: UIButton!
    @IBOutlet weak var homeAmountOfQuests: UILabel!
    @IBOutlet weak var homeLevelLabel: UILabel!
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var myQuestsButton: UIButton!
    
    //Outlets
    //Fix Names!!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var avatarPickedImage: UIImageView!
    @IBOutlet weak var homeUserClassLabel: UILabel!
    @IBOutlet weak var characterDimView: UIView!
    @IBOutlet weak var nameDimView: UIView!
    @IBOutlet weak var createNameTextField: UITextField!
    @IBOutlet weak var nameTransparentWhite: UIView!
    @IBOutlet weak var characterTransparentWhite: UIView!
    @IBOutlet weak var characterSaveButton: UIButton!
    @IBOutlet weak var nameSaveButton: UIButton!
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        PopUpViewService.setUpTextField(textField: textField)
        tableView.bounces = false
    
        getStartedButton.layer.cornerRadius = 10
        myQuestsButton.layer.cornerRadius = 10
        
        users = RealmService.shared.getObjetcs(type: UserModel.self)
        print(String(users.count))
        
        checkIfUserIsReturning()
    }
    
    
    //Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avatarCell")!
        let mAvatar = avatars[indexPath.row]
        cell.textLabel?.text = mAvatar
        cell.textLabel?.textAlignment  = .center
        cell.selectionStyle = .none
        return cell

    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mClass = avatars[indexPath.row]
        PopUpViewService.playSound(sound: "pop-sound.aiff")
        self.avatarPickedImage.image = UIImage(named: self.avatars[indexPath.row])
        self.characterSaveButton.isHidden = false
    }
    
    //Buttons
    @IBAction func characterSelectButton(_ sender: Any) {
        PopUpViewService.setUpPopUpView(popUpView: characterSelectorView, transparentePopUpView: characterTransparentWhite, mView: view, mDimView: dimView)
        self.nameCreatorView.becomeFirstResponder()
        characterTransparentWhite.layer.masksToBounds = true
        self.characterSaveButton.isHidden = true
        self.avatarPickedImage.image = UIImage(named: "avatar")

    }

    //Back Buttons
    @IBAction func nameBackButton(_ sender: Any) {
        PopUpViewService.playSound(sound: "pop-sound.aiff")
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: nameCreatorView, mDimView: characterDimView)
        self.textField.becomeFirstResponder()
       
    }
    
    @IBAction func characterBackButton(_ sender: Any) {
        PopUpViewService.setBackButtonInUpPopUpView(popUpView: characterSelectorView, mDimView: dimView)
        characterSaveButton.isHidden = true
    }
    
    
    //Save Buttons
    @IBAction func characterSaveButton(_ sender: Any) {
        PopUpViewService.setUpTextField(textField: textField)
        
        PopUpViewService.setUpPopUpView(popUpView: nameCreatorView, transparentePopUpView: nameTransparentWhite, mView: view, mDimView: characterDimView)
        
        textField.addTarget(self, action: #selector(checkUserInputInTextField), for: .editingChanged)
        checkUserInputInTextField()
        PopUpViewService.setUpTextField(textField: textField)
    }

     @IBAction func nameSaveButtonAction(_ sender: Any) {
            PopUpViewService.setBackButtonInUpPopUpView(popUpView: nameCreatorView, mDimView: dimView)
            PopUpViewService.setBackButtonInUpPopUpView(popUpView: characterSelectorView, mDimView: dimView)
           
            let user = UserModel(userName: createNameTextField.text!, userClass: mClass!, userLvl: 1, num: 0, den: 1)
            RealmService.shared.saveObjects(obj: [user])
            checkIfUserIsReturning()
    }
    
    //Helper Functions
    func checkIfUserIsReturning(){
        if users.isEmpty{
            welcomeBackView.isHidden = true
            firstTimeView.isHidden = false
            toMainQuestButton.isHidden = true
        } else {
            let user = users[0] as! UserModel
            firstTimeView.isHidden = true
            
            toMainQuestButton.isHidden = false
            welcomeBackView.isHidden = false
            homeAvatarIView.image = UIImage(named: user.userClass!)
            self.quests = RealmService.shared.getObjetcs(type: MainQuestModel.self)
            homeAmountOfQuests.text = "\(String(quests.count)) Quests In Progress"
            homeLevelLabel.text = "Level \(user.lvlString())"
            homeNameLabel.text = user.userName
            homeUserClassLabel.text = user.userClass
        }
    }
    
    @objc func checkUserInputInTextField(){
        PopUpViewService.animateFadeInView(viewIsHidden: (createNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!, view: nameSaveButton)
    }
}

