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
    @IBOutlet weak var lblCancel : UILabel!
    
    @IBOutlet weak var tbvPlaylist: UITableView!
  //  var listPlayList = [String]()
    var listPlayList:[Playlist] = [Playlist]()
    let alert = UIAlertView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()        
    }
    override func viewDidAppear(animated: Bool) {
        self.refresh()
        self.viewWillAppear(true)
    }
    func loadData(){
        listPlayList.removeAll()
        listPlayList = PlaylistDataManager.shareInstance.getAllPlaylistRealm()
    }
    
    func refresh(){
        loadData()
        tbvPlaylist.reloadData()
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
            let namTexfiled = alert.textFieldAtIndex(0)?.text
            var playList = Playlist()
            playList.title = namTexfiled!
            PlaylistDataManager.shareInstance.insertPlaylistRealm(playList)
            self.tbvPlaylist.reloadData()
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
        let cell = tbvPlaylist.dequeueReusableCellWithIdentifier("PlaylistTableViewCell") as! PlaylistTableViewCell
        
        return cell
    }
}