//
//  SongPlaylist.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
struct SongPlaylist {
    var uuidPlaylist : String
    var uuidSong : String
    init(){
        self.uuidPlaylist = NSUUID().UUIDString
        self.uuidSong = ""
    }
    
    init(songPlaylistDB:SongPlaylistDB){
        self.uuidPlaylist = songPlaylistDB.uuidPlaylist
        self.uuidSong = songPlaylistDB.uuidSong
    }
    init(uuidPlaylist : String , uuidSong : String) {
        self.uuidPlaylist = uuidPlaylist
        self.uuidSong = uuidSong
    }
}