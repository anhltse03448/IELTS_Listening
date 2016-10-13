//
//  CategoryObject.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class CategoryObject: NSObject {
    var title : String
    var img : String
    init(title : String , img : String) {
        self.title = title
        self.img = img
    }
}
