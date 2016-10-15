//
//  Utils.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/11/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class Utils: NSObject {
    class func seperateWord(content : String) -> [MyString] {
        var result = [MyString]()
        let tmp =  content.characters.split{$0 == " "}.map(String.init)
        var pos = 0
        var pre : Bool = false
        var tmpAnswer = [String]()
        while true {
            if tmp[pos] == "{" {
                tmpAnswer.removeAll()
                pre = true
            } else if tmp[pos] == "}" {
                result.append(MyString(content: "Choose a word", answer: tmpAnswer))
                pre = false
            } else {
                if pre == false {
                    result.append(MyString(content: tmp[pos]))
                } else {
                    tmpAnswer.append(tmp[pos])
                }
            }
            pos = pos + 1
            if pos == tmp.count {
                break
            }
        }
        return result
    }
    
    class func readFile(fileName : String) -> String {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        do {
            let content = try String(contentsOfFile: path!)
            return content
        } catch {
            
        }        
        return ""
    }
    
    class func random() -> [Int] {
        var result = [Int]()
        while true {
            let num = Int(arc4random_uniform(4))
            if result.contains(num) {
                
            } else {
                result.append(num)
            }
            if result.count == 4 {
                return result
            }
        }
    }
    
    class func checkIsFavorite(uuid : String) -> Bool {
        return false
    }
}

