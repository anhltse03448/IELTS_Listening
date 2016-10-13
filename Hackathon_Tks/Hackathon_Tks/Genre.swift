//
//  Type.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
import RealmSwift

class Genre: Object {
    dynamic var id : Int = 0 
    dynamic var title : String = ""
    dynamic var img : String = ""
    var listSong = List<Song>()
    
    func setValue(title : String, img : String , list : List<Song>) {
        self.title = title
        self.listSong = list
        self.img = img
    }
}
