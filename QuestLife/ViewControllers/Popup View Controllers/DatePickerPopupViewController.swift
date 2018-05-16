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
        mainQuest?.mainDate = dateLabel.text
        RealmService.shared.saveObjects(obj: [mainQuest!])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainQuest = Singleton.sharedInstance.mainQuest
        //dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle

        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
      
    }
   
    @IBAction func datePickerAction(_ sender: Any) {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var strDate = dateFormatter.string(from: datePicker.date)
        self.dateLabel.text = strDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
