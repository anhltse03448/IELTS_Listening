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
  
    var uuidSong : String?
    var isFromOther : Bool = false
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
        self.navigationController?.navigationBarHidden = true
        tbvPlaylist.showsVerticalScrollIndicator = false
        tbvPlaylist.tableFooterView = UIView(frame: CGRectZero)
        viewAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PlayListViewController.addTap(_:))))
        lblCancel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PlayListViewController.dismisViewController(_:))))
        if isFromOther == true {
            lblCancel.hidden = false
        } else {
            lblCancel.hidden = true
        }
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
        if buttonIndex == 1 { //OK
            let namTexfiled = alert.textFieldAtIndex(0)?.text
            var playList = Playlist()
            playList.title = namTexfiled!
            PlaylistDataManager.shareInstance.insertPlaylistRealm(playList)
            refresh()
            self.tbvPlaylist.reloadData()
        } else {
            
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
        cell.lblTitle.text = listPlayList[indexPath.row].title
        let uuid = listPlayList[indexPath.row].uuid
        
        let number = SongPlaylistDataManager.shareInstance.getCountPlaylistRealmById(uuid)
        if number != 1 {
            cell.lblCount.text = "\(number) videos"
        } else {
            cell.lblCount.text = "\(number) video"
        }
        
        let songid = SongPlaylistDataManager.shareInstance.findFistSongPlaylistDbByID(uuid).uuidSong
        let image = SongDataManager.shareInstance.findFistSongDbByID(songid).img
        if image == "" {
            cell.img.image = UIImage(named: "defaultPlaylist")
        } else {
            cell.img.image = UIImage(named: image)
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isFromOther == true {
            //add to playlist
            //uuid Playlist 
            let uuidPlaylist = listPlayList[indexPath.row].uuid
            //uuid Song
            
            let songPlayList = SongPlaylist(uuidPlaylist: uuidPlaylist, uuidSong: self.uuidSong!)
            SongPlaylistDataManager.shareInstance.insertSongPlaylistRealm(songPlayList)
            
            
            NSLog("add \(uuidSong) to \(uuidPlaylist)")
            self.dismissViewControllerAnimated(true, completion: { 
                
            })
            
        } else {
            let dest = self.storyboard?.instantiateViewControllerWithIdentifier("ListSongViewController") as! ListSongViewController
            
            dest.titleView = listPlayList[indexPath.row].title
//            let songPlaylist = SongPlaylistDataManager.shareInstance.getAllSongPlaylistRealmById(listPlayList[indexPath.row].uuid)
//            //dest.listSong =
//            var listSong = [Song]()
//            for item in songPlaylist {
//                let songDB = SongDataManager.shareInstance.findFistSongDbByID(item.uuidSong)
//                listSong.append(Song(songDb: songDB))
//            }
            dest.idPlaylist = listPlayList[indexPath.row].uuid
            
            
            self.navigationController?.pushViewController(dest, animated: true)
        }
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        PlaylistDataManager.shareInstance.deletePlaylist(listPlayList[indexPath.row].uuid)
        refresh()
    }
}