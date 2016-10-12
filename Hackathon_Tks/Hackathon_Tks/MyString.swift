//
//  MyString.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class MyString: NSObject {
    var content : String
    var answer : [String]?
    init(content : String) {
        self.content = content
        answer = nil
    }
    init(content : String , answer : [String]) {
        self.content = content
        self.answer = [String]()
        for i in answer {
            self.answer?.append(i)
        }
    }
}
