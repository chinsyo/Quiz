//
//  QuizCollectionViewCell.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class QuizCollectionViewCell: UICollectionViewCell {
    
    var question: Question! {
        
        didSet {
            contentLabel.text = question.content
            
            guard question.options.count >= 4 else {
                return
            }

            let resources = question.options.map { URL(string: $0.image)! }
            let processor = TintImageProcessor(tint: Constant.Color.blue.withAlphaComponent(0.3))
            for (index, button) in [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton].enumerated() {
                
                button?.kf.setImage(with: resources[index], for: .normal)
                button?.kf.setImage(with: resources[index], for: .selected, options: [.processor(processor)])
            }
        }
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var topLeftButton: UIButton! 
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    @IBAction func didTappedOptionButton(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton].forEach { button in
                button?.isSelected = false
            }
            sender.isSelected = true
        }
        
        guard question.options.count >= 4 else {
            return
        }
        
//        switch sender {
//        case topLeftButton:
//            choice = question.options[0]
//            
//        case topRightButton:
//            choice = question.options[1]
//            
//        case bottomLeftButton:
//            choice = question.options[2]
//            
//        case bottomRightButton:
//            choice = question.options[3]
//            
//        default:
//            break
//        }
//        
//        question.choice = choice
    }

}
