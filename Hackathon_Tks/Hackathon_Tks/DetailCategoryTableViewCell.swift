//
//  DetailCategoryTableViewCell.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
protocol DetailCategoryDelegate {
    func click(cell : DetailCategoryTableViewCell)
}
class DetailCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lbl : UILabel!
    @IBOutlet weak var durationLbl : UILabel!
    @IBOutlet weak var countLbl : UILabel!
    @IBOutlet weak var showMoreImg : UIImageView!
    @IBOutlet weak var showMoreView : UIView!
    var delegate : DetailCategoryDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        showMoreImg.userInteractionEnabled = true
        showMoreImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryTableViewCell.showMore(_:))))
        showMoreView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryTableViewCell.showMore(_:))))
    }
    
    func showMore(gesture : UITapGestureRecognizer) {
        if delegate != nil {
            delegate?.click(self)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
