//
//  SongObject.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class SongObject: NSObject {
    var title : String = ""
    var img : String = ""
    var length : String = ""
    var number_word : Int = 0
    var result : Double = 0
    var fileSource : String = ""
    var linkYoutube : String = ""
    
    init(song : Song) {
        self.title = song.title
        self.img = song.img
        self.length = song.length
        self.number_word = song.number_word
        self.result = song.result
        self.fileSource = song.fileSource
        self.linkYoutube = song.linkYoutube
    }
}
