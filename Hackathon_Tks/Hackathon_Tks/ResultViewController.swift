//
//  ResultViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/14/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    @IBOutlet weak var viewResult : UIView!
    @IBOutlet weak var lblResult : UILabel!
    @IBOutlet weak var lblDone : UILabel!
    @IBOutlet weak var viewDone : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentSizeInPopup = CGSizeMake(300, 250)
        self.landscapeContentSizeInPopup = CGSizeMake(300, 170)
        self.popupController.navigationBar.hidden = true
        self.popupController.navigationBarHidden = true
        self.popupController.cornerRadius = 5
        viewResult.cornerRadius = viewResult.frame.width / 2
        viewResult.backgroundColor = UIColor.init(rgba: "#5fb760")
        lblResult.text = "100%"
        
        lblDone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ResultViewController.dismisPopup(_:))))
        viewDone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ResultViewController.dismisPopup(_:))))
    }
    
    func dismisPopup(gesture : UITapGestureRecognizer) {
        self.popupController.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
