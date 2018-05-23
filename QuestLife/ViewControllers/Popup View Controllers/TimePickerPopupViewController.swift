//
//  TimePickerPopupViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/23/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

class TimePickerPopupViewController: UIViewController {
    var mainQuest: MainQuestModel?
    var currentTime: String?

    @IBOutlet weak var tPicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainQuest = Singleton.sharedInstance.mainQuest
        currentTime = getDate(date: tPicker.date)
        timeLabel.text = currentTime
    }
    

    @IBAction func timePicker(_ sender: Any) {
        currentTime = getDate(date: tPicker.date)
        timeLabel.text = currentTime
    }
    
    @IBAction func setTimeButtonTapped(_ sender: Any) {
        
        let mTitle = self.mainQuest?.mainTitle
        let mBoss = self.mainQuest?.mainBoss
        let mDate = self.mainQuest?.mainDate
        let mTime = self.currentTime
        let mKey = self.mainQuest?.mainQuestID
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime!, key: mKey!)])
    }
    
    
    func getDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH mm a"
        return dateFormatter.string(from: date)
    }
}
