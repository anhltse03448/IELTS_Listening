//
//  Song.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

struct Song {
    var uuid:String
    var genreID:String
    var title:String
    var img:String
    var length:String
     var number_word : Int
    var result : Double
    var fileSource : String
    var linkYoutube : String
    
    init(songDb:SongDB){
        
        self.uuid = songDb.uuid
        self.genreID = songDb.genreID
        self.title = songDb.title
        self.img = songDb.img
        self.length = songDb.length
        self.number_word  = songDb.number_word
        self.result  = songDb.result
        self.fileSource  = songDb.fileSource
        self.linkYoutube  = songDb.linkYoutube

    }
    init(){
        self.uuid = NSUUID().UUIDString
        self.genreID = ""
        self.title = ""
        self.img = ""
        self.length = ""
        self.number_word  = 0
        self.result  = 0
        self.fileSource  = ""
        self.linkYoutube  = ""
    }

}
