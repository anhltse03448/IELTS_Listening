//
//  Favorite.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
struct Playlist {
    var uuid : String
    var title : String
    init(){
        self.uuid = ""
        self.title = ""
    }
    
    init(playlistDB:PlaylistDB){
        self.uuid = playlistDB.uuid
        self.title = playlistDB.title
    }
}