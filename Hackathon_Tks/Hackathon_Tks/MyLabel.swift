//
//  MyLabel.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class MyLabel: UILabel {
    var answer = [String]()
    var type = 0
    var isTrue : Bool = false    
    func setAnswers(answer : [String]) {
        type = 1
        for i in answer {
            self.answer.append(i)
        }
    }
}
