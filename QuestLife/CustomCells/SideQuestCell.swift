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

class SideQuestCell: UICollectionViewCell {
    weak var delegate: SideQuestCellDelegate?

    @IBOutlet weak var checkBox: Checkbox!
    @IBOutlet weak var sideQuestTitleLabel: UILabel!
    
    @IBOutlet weak var sideQuestDeleteButton: UIButton!
    
  
    func Configure(with sideQuestModel: SideQuestModel){
        sideQuestTitleLabel.text = sideQuestModel.sideTitle
        if sideQuestModel.isChecked == true{
            checkBox.isChecked = true
        
            let text = sideQuestModel.sideTitle
            let textRange = NSMakeRange(0, (text?.count)!)
            let attributedText = NSMutableAttributedString(string: text!)
            attributedText.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                        value: NSUnderlineStyle.styleSingle.rawValue,
                                        range: textRange)
            sideQuestTitleLabel.attributedText = attributedText
            sideQuestTitleLabel.textColor = .red
          

            //sideQuestTitleLabel.text
        } else{
            checkBox.isChecked = false
            sideQuestTitleLabel.textColor = .black
        
        }
        checkBox.borderStyle = .circle
        checkBox.checkmarkStyle = .circle
        checkBox.useHapticFeedback = true
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)

    }
}

