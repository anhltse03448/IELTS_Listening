//
//  Song.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import Realm

class SongDB: Object {
    dynamic var uuid : String = ""
    dynamic var genreID : String = ""
    dynamic var title : String = ""
    dynamic var img : String = ""
    dynamic var length : String = ""
    dynamic var number_word : Int = 0
    dynamic var result : Double = 0
    dynamic var fileSource : String = ""
    dynamic var linkYoutube : String = ""
    dynamic var createDate = NSDate()
    
//    func setValue(uuid : String , genreID : String ,  title : String , img : String , length : String , number_word : Int , fileSource : String , linkYoutube : String , result : Double) {
//        self.uuid = uuid
//        self.genreID = genreID
//        self.title = title
//        self.img = img
//        self.length = length
//        self.number_word = number_word
//        self.fileSource = fileSource
//        self.linkYoutube = linkYoutube
//        self.result = result
//    }
}