//
//  DatePickerPopupViewController.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/14/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit
import FSCalendar

class DatePickerPopupViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate{
    var mainQuest: MainQuestModel?
    
    @IBOutlet weak var dateQuestLabel: UILabel!
    
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var currentDate: String?
   
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        setDateButton.isHidden = false

        return dateFormatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = getDate(date: date)
    }
    
    
    @IBAction func setDateButtonTapped(_ sender: Any) {
        
        let mTitle = self.mainQuest?.mainTitle
        let mBoss = self.mainQuest?.mainBoss
        let mDate = self.currentDate
        let mTime = self.mainQuest?.mainTime
        let mKey = self.mainQuest?.mainQuestID
        
        RealmService.shared.saveObjects(obj: [MainQuestModel(title: mTitle!, boss: mBoss!, date: mDate!, time: mTime!, key: mKey!)])
        //self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainQuest = Singleton.sharedInstance.mainQuest
        setDateButton.isHidden = true
    }
   
   
}
