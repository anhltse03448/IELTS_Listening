//
//  Genre.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//


import UIKit

struct Genre {
    var uuid:String
    var title:String
    var img:String

    init(){
        self.uuid = NSUUID().UUIDString
        self.title = ""
        self.img = ""
    }
    
    init(genreDb:GenreDB){
        self.uuid = genreDb.uuid
        self.title = genreDb.title
        self.img = genreDb.img
    }
}
