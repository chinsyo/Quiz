//
//  ModalViewController.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    var buttonHandler: ((UIButton) -> Void)? = nil
    var content: String = "Content"
    
    var action: String = "Button"
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = self.content
        }
    }
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.setTitle(self.action, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 10
    }
    
    @IBAction func didTappedActionButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
        if let handler = self.buttonHandler {
            handler(sender)
        }
    }
}
