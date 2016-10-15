//
//  Favorite.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
struct Favorite {
    var songID:String
    
    init(){
        self.songID = ""
    }
    
    init(favoriteDB:FavoriteDB){
        self.songID = favoriteDB.songID
    }
}