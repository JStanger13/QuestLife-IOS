//
//  DatePickerPopupViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/14/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

class DatePickerPopupViewController: UIViewController{
    var mainQuest: MainQuestModel?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateLabel: UILabel!
    
   
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func setDateButton(_ sender: Any) {
        //mainQuest?.mainDate = dateLabel.text
        let mTitle = self.mainQuest?.mainTitle
        let mBoss = self.mainQuest?.mainBoss
        let mDate = self.dateLabel.text!
        let mTime = self.mainQuest?.mainTime
        let mKey = self.mainQuest?.mainQuestID
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate, time: mTime!, key: mKey!)])
        //self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainQuest = Singleton.sharedInstance.mainQuest
        //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        print("Time is \(mainQuest?.mainTime as! String)")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
      
    }
   
    @IBAction func datePickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
