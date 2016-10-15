//
//  SongPlaylistDB.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
import RealmSwift

class SongPlaylistDB: Object {
    dynamic var uuidPlaylist : String = ""
    dynamic var uuidSong : String = ""
}
