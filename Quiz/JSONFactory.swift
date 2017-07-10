//
//  JSONFactory.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/24.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import Foundation

public struct JSONFactory {
    
    static func questions(with fileName: String) -> [Question] {
        do {
            let path = Bundle.main.path(forResource: "zquestions", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Array<String>]
            
            let result = json.map { (k, v) in
                Question(content: k, options: v.map { Option(image: $0) })
            }
            
            return result
        } catch {
            assertionFailure("Couldn't load json from local file.")
            return [Question]()
        }
    }
}
