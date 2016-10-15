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
    @IBOutlet weak var lblCancel : UILabel!
    
    var listPlayList = [String]()
    
    let alert = UIAlertView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()        
    }
    
    func initViewController() {
        viewAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PlayListViewController.addTap(_:))))
        lblCancel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PlayListViewController.dismisViewController(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func dismisViewController(gesture : UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true) {
            
        }
    }

    
    func addTap(gesture : UITapGestureRecognizer){
        alert.delegate = self
        alert.title = "New Playlist"
        alert.message = "Enter a name for this playlist"
        alert.tintColor = TINT_COLOR
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.addButtonWithTitle("Cancel")
        alert.addButtonWithTitle("Save")
        alert.show()
        
    }
}
extension PlayListViewController : UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 { //cancel
            
        } else {
            listPlayList.insert("\(alert.textFieldAtIndex(0)?.text)", atIndex: 0)
            self.tbl.reloadData()
        }
    }
}

extension PlayListViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlayList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("PlaylistTableViewCell") as! PlaylistTableViewCell
        
        return cell
    }
}