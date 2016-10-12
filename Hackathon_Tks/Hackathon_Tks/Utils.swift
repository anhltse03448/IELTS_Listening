//
//  Utils.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/11/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class Utils: NSObject {
    class func seperateWord(content : String) -> [String] {
        return content.characters.split{$0 == " "}.map(String.init)
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
}
