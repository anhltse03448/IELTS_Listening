//
//  CategoryObject.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class CategoryObject: NSObject {
    var uuid : String
    var title : String
    var img : String
    init(uuid : String , title : String , img : String) {
        self.uuid = uuid
        self.title = title
        self.img = img
    }
}
