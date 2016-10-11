//
//  WordView.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/11/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import SnapKit

class WordView: UIView {    
    let fontSize : CGFloat = 50
    func setWord(content : String) {
        let label = UILabel()
        label.font = label.font.fontWithSize(fontSize)
        label.text = content
        label.sizeToFit()
        
        self.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.centerX.equalTo(label)
            make.centerY.equalTo(label)
        }        
    }
}
