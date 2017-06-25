//
//  Option.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import Foundation

public class Option {
    
    var image: String
    init(image: String) {
        self.image = image
    }
}

extension Option: CustomStringConvertible {
    
    public var description: String {
        get {
            return "image: \(image))"
        }
    }
}

extension Option: Equatable {
    
    public static func ==(lhs: Option, rhs: Option) -> Bool {
        return lhs.image == rhs.image
    }
}
