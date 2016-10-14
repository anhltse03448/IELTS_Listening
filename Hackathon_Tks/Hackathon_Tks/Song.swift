//
//  Song.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import RealmSwift

class Song: Object {
    dynamic var index : Int = 0
    dynamic var title : String = ""
    dynamic var img : String = ""
    dynamic var length : String = ""
    dynamic var number_word : Int = 0
    dynamic var result : Double = 0
    dynamic var fileSource : String = ""
    dynamic var linkYoutube : String = ""
    
    func setValue(index : Int , title : String , img : String , length : String , number_word : Int , fileSource : String , linkYoutube : String , result : Double) {
        self.index = index
        self.title = title
        self.img = img
        self.length = length
        self.number_word = number_word
        self.fileSource = fileSource
        self.linkYoutube = linkYoutube
        self.result = result
    }
}