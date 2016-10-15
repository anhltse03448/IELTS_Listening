//
//  ListSongViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class ListSongViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    @IBOutlet weak var back_img : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var backView : UIView!
    var titleView : String?
    var idPlaylist : String?
    var currentSongID : String?
    var isAddToFavorite : Bool = false
    
    var listSong = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.tableFooterView = UIView(frame: CGRectZero)
        reloadData()
        self.navigationController?.navigationBarHidden = true
        back_img.userInteractionEnabled = true
        back_img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ListSongViewController.backTap(_:))))
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ListSongViewController.backTap(_:))))
        
        self.lblTitle.text = titleView
    }
    
    func backTap(gesture : UITapGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func reloadData() {
        let songPlaylist = SongPlaylistDataManager.shareInstance.getAllSongPlaylistRealmById(idPlaylist!)
        //dest.listSong =
        self.listSong.removeAll()
        for item in songPlaylist {
            let songDB = SongDataManager.shareInstance.findFistSongDbByID(item.uuidSong)
            listSong.append(Song(songDb: songDB))
        }
        tbl.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ListSongViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSong.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("DetailCategoryTableViewCell") as! DetailCategoryTableViewCell
        
        cell.showMoreImg.hidden = true
        cell.showMoreView.hidden = true
        
        cell.lbl.text = listSong[indexPath.row].title
        cell.durationLbl.text = listSong[indexPath.row].length
        cell.countLbl.text = "\(listSong[indexPath.row].number_word)"
        cell.lblScore.text =  String(format: "%.0f%", listSong[indexPath.row].result * 100) + "%" //"\(listSong[indexPath.row].result)"
        let url = listSong[indexPath.row].img
        cell.img.image = UIImage(named: url)
        
        //cell.delegate = self
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.showLoadingHUD()
        tbl.deselectRowAtIndexPath(indexPath, animated: true)
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        dest.currentSong = listSong[indexPath.row]
        dest.titleTab = listSong[indexPath.row].title
        self.presentViewController(dest, animated: true) {
            self.hideLoadingHUD()
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 103
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let currentSongID = listSong[indexPath.row].uuid
        SongPlaylistDataManager.shareInstance.deleteSongpFromPlaylist(idPlaylist!, uuidSong: currentSongID)
        reloadData()
//        let favorite = favorites[indexPath.row]
//        let favoriteDB = FavoriteDataManager.shareInstance.findFistFavoriteDbByID(favorite.songID)
//        if favoriteDB.songID != ""{
//            FavoriteDataManager.shareInstance.deleteFavoriteRealm(favoriteDB)
//            self.refresh()
//        }
    }

}
extension ListSongViewController : DetailCategoryDelegate {
    func click(cell: DetailCategoryTableViewCell) {
        let number = tbl.indexPathForCell(cell)
        var textToPlaylist = "Add to Favorite"
        isAddToFavorite = true
        if FavoriteDataManager.shareInstance.isInFavorites(listSong[(number?.row)!].uuid) {
            textToPlaylist = "Remove From Favorite"
            isAddToFavorite = false
        }
        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: textToPlaylist, "Add to Playlist")
        actionSheet.tintColor = UIColor.init(rgba: "#5fb760")
        currentSongID = listSong[(number?.row)!].uuid
        
        actionSheet.showInView(self.view)    }
}
extension ListSongViewController : UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 2:
            let dest = self.storyboard?.instantiateViewControllerWithIdentifier("PlayListViewController") as! PlayListViewController
            dest.uuidSong = currentSongID
            dest.isFromOther = true
            self.presentViewController(dest, animated: true, completion: {
                
            })
            break
        default:
            if isAddToFavorite {
                var favorite = Favorite()
                favorite.songID = currentSongID!
                FavoriteDataManager.shareInstance.insertFavoriteRealm(favorite)
            } else {
                FavoriteDataManager.shareInstance.deleteFavoriteRealmByUUID(currentSongID!)
            }
            
        }
        
    }
}
