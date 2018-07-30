//
//  MainQuestCell.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

protocol MainQuestCellDelegate: class {
    func delete(cell: MainQuestCell)
    func setDate(cell: MainQuestCell)
    func setTime(cell: MainQuestCell)
    func edit(cell: MainQuestCell)
}

class MainQuestCell: UITableViewCell {
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var outsideView: UIView!

    weak var delegate: MainQuestCellDelegate?
    
    @IBOutlet weak var timeButtonImage: UIImageView!
    @IBOutlet weak var dateButtonImage: UIImageView!

    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var dateView: UIView!
    
    
    @IBOutlet weak var mainQuestTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bossImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    func Configure(with mainQuestModel: MainQuestModel){
        bossImage.image = UIImage(named: mainQuestModel.mainBoss)
        mainQuestTitleLabel.text = mainQuestModel.mainTitle
        dateLabel.text = mainQuestModel.mainDate
        timeLabel.text = mainQuestModel.mainTime
        
       
        if (mainQuestModel.mainTime.trimmingCharacters(in: .whitespaces).isEmpty){
            timeButtonImage.image = UIImage(named: "white_time")
        }else{
            timeButtonImage.image = UIImage(named: "red_time")
        }
        
        if (mainQuestModel.mainDate.trimmingCharacters(in: .whitespaces).isEmpty){
            dateButtonImage.image = UIImage(named: "white_calendar")
        }else{
            dateButtonImage.image = UIImage(named: "red_calendar")
        }
        
 
        insideView.layer.cornerRadius = 5
        insideView.layer.masksToBounds = true
        outsideView.layer.cornerRadius = 10
    }
    
    
  
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
        print("DeleteDelegate")

    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        delegate?.setDate(cell: self)
        print("DateDelegate")
    }
    
    @IBAction func timeButtonTapped(_ sender: Any) {
        delegate?.setTime(cell: self)
        print("TimeDelegate")
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        delegate?.edit(cell: self)
        print("EditDelegate")
    }
}
