//
//  RootViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//


import UIKit
import RealmSwift

class RootViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    var users : Results <Object>!
    var quests: Results<Object>!
    @IBOutlet weak var dimView: UIView!

    @IBOutlet weak var avatarPickedImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    let avatars = ["Knight", "Viking", "Gnome", "Girl-Elf", "Boy-Elf", "Prince", "Wizard", "Princess", "Fairy"]
    
    @IBOutlet weak var welcomeBackView: UIView!
    @IBOutlet weak var homeAvatarIView: UIImageView!
    @IBOutlet weak var homePickedAvatarView: UIImageView!
    @IBOutlet weak var homePickedNameLabel: UILabel!


    @IBOutlet weak var toMainQuestButton: UIButton!
    
    @IBOutlet weak var homeUserClassLabel: UILabel!
    @IBOutlet weak var toPagerViewButton: UIButton!
    
    @IBOutlet var characterSelectorView: UIView!
    @IBOutlet var nameCreatorView: UIView!
    
    @IBOutlet var emptyNameCreatorView: UIView!
    @IBOutlet weak var emptyNameTransparentWhite: UIView!

    @IBOutlet weak var characterDimView: UIView!
    @IBOutlet weak var nameDimView: UIView!


    
    
    @IBOutlet weak var createNameTextField: UITextField!
    
    @IBOutlet weak var nameTransparentWhite: UIView!
    @IBOutlet weak var characterTransparentWhite: UIView!
    var mName: String?
    var mClass: String?

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return avatars.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        mClass = avatars[row]
        avatarPickedImage.image = UIImage(named: avatars[row])
        return avatars[row]
    }
    @IBAction func emptyNameBackButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.emptyNameCreatorView.removeFromSuperview()
            self.emptyNameCreatorView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.emptyNameCreatorView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.nameDimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }

    @IBAction func nameBackButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.nameCreatorView.removeFromSuperview()
            self.nameCreatorView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.nameCreatorView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.characterDimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    @IBAction func characterSelectButton(_ sender: Any) {
        characterSelectorView.center = view.center
        characterSelectorView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        characterSelectorView.layer.cornerRadius = 10
        characterTransparentWhite.layer.masksToBounds = true
        characterTransparentWhite.layer.cornerRadius = 5
        view.addSubview(characterSelectorView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.characterSelectorView.transform = .identity
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.8
        })
    }
    
    @IBAction func characterSaveButton(_ sender: Any) {
        //homePickedAvatarView.image = avatarPickedImage.image
        nameCreatorView.center = view.center
        nameCreatorView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        nameCreatorView.layer.cornerRadius = 10
        nameTransparentWhite.layer.masksToBounds = true
        nameTransparentWhite.layer.cornerRadius = 5
        view.addSubview(nameCreatorView)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.nameCreatorView.transform = .identity
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.characterDimView.alpha = 0.8
            //self.deletePopupView.transform = .identity
        })
        
    }
    
    @IBAction func nameSaveButton(_ sender: Any) {
        
        if (createNameTextField.text?.isEmpty)! {
            emptyNameCreatorView.center = view.center
            emptyNameCreatorView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            emptyNameCreatorView.layer.cornerRadius = 10
            emptyNameTransparentWhite.layer.masksToBounds = true
            emptyNameTransparentWhite.layer.cornerRadius = 5
            view.addSubview(emptyNameCreatorView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.emptyNameCreatorView.transform = .identity
            })
        
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.nameCreatorView.alpha = 0.8
            })
        }else{
            mName = createNameTextField.text
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.nameCreatorView.removeFromSuperview()
            self.nameCreatorView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.nameCreatorView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.characterSelectorView.removeFromSuperview()
            self.characterSelectorView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.characterSelectorView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
        
        
        let user = UserModel(userName: mName!, userClass: mClass!, userLvl: 1, num: 0, den: 1)
        RealmService.shared.saveObjects(obj: [user])
        
        welcomeBackView.isHidden = false
        homeAvatarIView.image = UIImage(named: user.userClass!)
        self.quests = RealmService.shared.getObjetcs(type: MainQuestModel.self)
        homeAmountOfQuests.text = "\(String(quests.count)) Quests In Progress"
        homeLevelLabel.text = "Level \(user.lvlString())"
        homeNameLabel.text = user.userName
        homeUserClassLabel.text = user.userClass
        firstTimeView.isHidden = true
        toMainQuestButton.isHidden = false
    }
}
    
    @IBAction func characterBackButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            //self.dimView.alpha = 0
            self.characterSelectorView.removeFromSuperview()
            self.characterSelectorView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            self.characterSelectorView.removeFromSuperview()
        }
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0.0
            //self.deletePopupView.transform = .identity
        })
    }
    
    
    @IBOutlet weak var homeAmountOfQuests: UILabel!
    @IBOutlet weak var homeLevelLabel: UILabel!
    @IBOutlet weak var homeNameLabel: UILabel!
    
    @IBOutlet weak var firstTimeView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let realm = RealmService.shared.realm
        users = RealmService.shared.getObjetcs(type: UserModel.self)
        print(String(users.count))
        
        if users.isEmpty{
            welcomeBackView.isHidden = true
            firstTimeView.isHidden = false

            toMainQuestButton.isHidden = true
            toPagerViewButton.isHidden = true
        } else {
            let user = users[0] as! UserModel
            firstTimeView.isHidden = true

            toPagerViewButton.isHidden = true
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

