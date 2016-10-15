//
//  CategoryTableViewCell.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

protocol CategoryProtocol {
    func tap(cell : CategoryTableViewCell , index : Int)
}

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lbl : UILabel!
    
    @IBOutlet weak var img2 : UIImageView!
    @IBOutlet weak var lbl2 : UILabel!
    var delegate : CategoryProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.userInteractionEnabled = true
        img2.userInteractionEnabled = true
        img.tag = 0
        img2.tag = 1
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CategoryTableViewCell.imgTap(_:))))
        img2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CategoryTableViewCell.imgTap(_:))))
    }
    
    func imgTap(gesture : UITapGestureRecognizer){
        if delegate != nil {
            delegate?.tap(self, index: (gesture.view?.tag)!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
