//
//  TimePickerPopupViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/14/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

class TimePickerPopupViewController: UIViewController {
    var mainQuest: MainQuestModel?
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func timeBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setTimeButton(_ sender: Any) {
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: (mainQuest?.mainTitle)!, boss: (mainQuest?.mainBoss)!, date:(mainQuest?.mainDate!)!, time: timeLabel.text!, key: (mainQuest?.mainQuestID)!)])
    }
    
    @IBAction func timePickerAction(_ sender: Any) {
       
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        var strTime = timeFormatter.string(from: timePicker.date)
        self.timeLabel.text = strTime
 
        
    }
    
    @IBOutlet weak var setTimeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainQuest = Singleton.sharedInstance.mainQuest
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        var strTime = timeFormatter.string(from: timePicker.date)
        self.timeLabel.text = strTime

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
