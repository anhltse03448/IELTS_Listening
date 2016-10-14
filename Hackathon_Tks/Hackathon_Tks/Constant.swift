//
//  Constant.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class Constant: NSObject {
    struct Systems {
        static let scale : CGFloat                          = UIScreen.mainScreen().bounds.size.width/375.0
        static let screen_size : CGSize                     = UIScreen.mainScreen().bounds.size
        static let device_version                           = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        static let device_name: String                      = UIDevice.currentDevice().name
        static let system_name: String                      = UIDevice.currentDevice().systemName
        static let system_version: String                   = UIDevice.currentDevice().systemVersion
    }
}
