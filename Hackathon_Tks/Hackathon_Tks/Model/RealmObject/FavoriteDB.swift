//
//  Favorite.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class FavoriteDB: Object {
    dynamic var songID : String = ""
    dynamic var createDate = NSDate()
}
