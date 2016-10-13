//
//  PlayListViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class PlayListViewController: BaseViewController {
    @IBOutlet weak var viewAdd : UIView!
    @IBOutlet weak var tbl : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PlayListViewController.addTap(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func addTap(gesture : UITapGestureRecognizer){
        let alert = UIAlertView()
        alert.title = "New Playlist"
        alert.message = "Enter a name for this playlist"
        alert.tintColor = TINT_COLOR
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.addButtonWithTitle("Cancel")
        alert.addButtonWithTitle("Save")
        alert.show()
    }
}
