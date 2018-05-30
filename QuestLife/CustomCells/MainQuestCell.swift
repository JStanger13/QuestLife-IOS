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
    //func goToSideQuest(cell: MainQuestCell)
}

class MainQuestCell: UICollectionViewCell {
    
    weak var delegate: MainQuestCellDelegate?
    
    
    @IBOutlet weak var bossHealthProgressBar: UIProgressView!
    @IBOutlet weak var mainQuestTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bossImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    func Configure(with mainQuestModel: MainQuestModel){
        bossImage.image = UIImage(named: mainQuestModel.mainBoss)
        mainQuestTitleLabel.text = mainQuestModel.mainTitle
        dateLabel.text = mainQuestModel.mainDate
        timeLabel.text = mainQuestModel.mainTime
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
        
}
