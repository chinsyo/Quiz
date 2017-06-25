//
//  OptionButton.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit

class OptionButton: UIButton {
    
}

extension UIImage {
    
    func original() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }

    func covered() -> UIImage {
        
        let cover = UIImage(named: "cover")
        
        UIGraphicsBeginImageContext(self.size)

        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size), blendMode: CGBlendMode.copy, alpha: 1)
        cover?.draw(in: CGRect(origin: CGPoint.zero, size: self.size), blendMode: CGBlendMode.copy, alpha: 0.3)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result!
    }
}
