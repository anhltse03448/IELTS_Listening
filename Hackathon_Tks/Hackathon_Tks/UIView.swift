//
//  UIView.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/14/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(self, options: nil)[0] as? UIView
    }
}