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
}

class MainQuestCell: UICollectionViewCell {
    
    weak var delegate: MainQuestCellDelegate?
    
    @IBOutlet weak var mainQuestTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bossImage: UIImageView!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    func Configure(with mainQuestModel: MainQuestModel){
        bossImage.image = UIImage(named: mainQuestModel.mainBoss!)
        mainQuestTitleLabel.text = mainQuestModel.mainTitle
        dateLabel.text = mainQuestModel.mainDate
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    @IBAction func dateButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func timeButtonTapped(_ sender: Any) {
        
    }
    
}
