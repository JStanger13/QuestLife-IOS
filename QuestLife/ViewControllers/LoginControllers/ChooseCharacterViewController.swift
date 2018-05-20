//
//  ChooseCharacterViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/10/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseCharacterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //var users : Results <UserModel>!

    @IBOutlet weak var avatarPickedImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    let avatars = ["knight", "viking", "gnome", "girl-elf", "boy-elf", "prince", "wizard", "princess", "fairy"]

    @IBOutlet weak var avatarClassLabel: UILabel!
    
    @IBOutlet weak var createCharacterButton: UIButton!
    
    @IBAction func createButtonTapped(_ sender: Any) {
        let userClass = avatarClassLabel.text!
        //print(userClass)
        let user = UserModel(userName: textField.text!, userClass: userClass)
        RealmService.shared.saveObjects(obj: [user])

        //Singleton.sharedInstance.user = user
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        createCharacterButton.isHidden = true
        textField.addTarget(self, action: #selector(ChooseCharacterViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        let realm = RealmService.shared.realm
        //users = realm.objects(UserModel.self)

    }
    
    @IBOutlet weak var textField: UITextField!
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(textField.text)
        if (textField.text?.isEmpty)! {
            print("Empty")

            self.createCharacterButton.isHidden = true
        } else{
            print("Full!")

            self.createCharacterButton.isHidden = false

        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return avatars.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        avatarClassLabel.text = avatars[row]
        avatarPickedImage.image = UIImage(named: avatars[row])
        return avatars[row]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
