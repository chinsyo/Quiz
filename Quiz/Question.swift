//
//  Question.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import Foundation

public class Question {
    
    var content: String
    var options: [Option]
    let answer: Option
    var choice: Option?
    
    init(content: String, options: [Option]) {
        self.content = content
        self.options = options
        self.answer = options.first!
    }
}

extension Question: CustomStringConvertible {
    
    public var description: String {
        get {
            return "# content: \(content) options: \(options) answer: \(answer) #"
        }
    }
}

extension Question: Equatable {
    
    public static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.content == rhs.content
    }
}
