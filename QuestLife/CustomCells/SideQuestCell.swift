//
//  SideQuestCell.swift
//  QuestLife
//
//  Created by Justin Stanger on 5/13/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import UIKit

protocol SideQuestCellDelegate: class {
    func delete(cell: SideQuestCell)
  }

class SideQuestCell: UITableViewCell {
    weak var delegate: SideQuestCellDelegate?
    @IBOutlet weak var outsideView: UIView!
    @IBOutlet weak var insideView: UIView!

    @IBOutlet weak var checkBox: Checkbox!
    @IBOutlet weak var sideQuestTitleLabel: UILabel!
    
    @IBOutlet weak var sideQuestDeleteButton: UIButton!
    @IBOutlet weak var whiteGarbageView: UIImageView!

    @IBOutlet weak var strikethrough: UIProgressView!
    
    func Configure(with sideQuestModel: SideQuestModel){
        sideQuestTitleLabel.text = sideQuestModel.sideTitle
        outsideView.layer.cornerRadius = 10

        if sideQuestModel.isChecked == true{
            checkBox.isChecked = true
            strikethrough.progress = 1.0
            strikethrough.animate(duration: 0.1)
        } else{
            checkBox.isChecked = false
            strikethrough.progress = 0.0
        }
        checkBox.borderStyle = .circle
        checkBox.checkmarkStyle = .circle
        checkBox.useHapticFeedback = true
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }
}


