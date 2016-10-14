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
    dynamic var uuid : String = ""
    dynamic var title : String = ""
    dynamic var img : String = ""
    //var listSong = List<Song>()
    
    func setValue(uuid : String , title : String, img : String) {
        self.uuid = uuid
        self.title = title
        //self.listSong = list
        self.img = img
    }
}
