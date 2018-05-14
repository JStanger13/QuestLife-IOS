//
//  MainQuestCell.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

class MainQuestCell: UICollectionViewCell {
    
    @IBOutlet weak var mainQuestTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bossImage: UIImageView!
    
    func Configure(with mainQuestModel: MainQuestModel){
        bossImage.image = UIImage(named: mainQuestModel.mainBoss!)
        mainQuestTitleLabel.text = mainQuestModel.mainTitle
        dateLabel.text = mainQuestModel.mainDate
    }
}
