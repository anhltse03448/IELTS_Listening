//
//  FavoriteViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import JLToast

class FavoriteViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    var favorites: [Favorite] = [Favorite]()
    @IBOutlet weak var lblEdit : UILabel!
    @IBOutlet weak var viewNil : UIView!
    var isEditting : Bool = false
    var listCellTap = [Int]()

    var currentFavorite : Favorite?
    
    @IBOutlet weak var tbvFavorite: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNil.hidden = false
        lblEdit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FavoriteViewController.btnTapEdit(_:))))
        tbl.tableFooterView = UIView(frame: CGRectZero)
        tbl.tintColor = GREEN_COLOR
        tbl.showsVerticalScrollIndicator = false
        
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.refresh()
        self.viewWillAppear(true)
    }
    
    func btnTapEdit(gesture : UITapGestureRecognizer) {
        isEditting = !isEditting
        if isEditting {
            listCellTap.removeAll()
            lblEdit.text = "Delete"
            tbl.allowsMultipleSelectionDuringEditing = true
            tbl.setEditing(true, animated: true)
        } else {
            lblEdit.text = "Edit"
            if listCellTap.count == 0 {
                tbl.allowsMultipleSelectionDuringEditing = false
                tbl.setEditing(false, animated: true)
                return
            }
            let alertController = UIAlertController(title: "Delete \(listCellTap.count) Favorite Songs", message: "Do you sure want Delete", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                //FavoriteDataManager.shareInstance.deleteAllFavorite()
                for i in self.listCellTap {
                    FavoriteDataManager.shareInstance.deleteFavoriteRealmByUUID(self.favorites[i].songID)
                }
                self.refresh()
            }
            let Cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            alertController.addAction(Cancel)
            self.presentViewController(alertController, animated: true, completion: nil)
            tbl.allowsMultipleSelectionDuringEditing = false
            tbl.setEditing(false, animated: true)
            
        }
    }
    
    func loadData(){
        favorites.removeAll()
        favorites = FavoriteDataManager.shareInstance.getAllFavoriteRealm()
        if favorites.count != 0 {
            lblEdit.hidden = false
        } else {
            lblEdit.hidden = true
        }
        if favorites.count == 0 {
            viewNil.hidden = false
        } else {
            viewNil.hidden = true
        }
    }
    
    func refresh(){
        loadData()
        tbvFavorite.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        
    }

}

extension FavoriteViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("DetailCategoryTableViewCell") as! DetailCategoryTableViewCell
        let song = SongDataManager.shareInstance.findFistSongDbByID(favorites[indexPath.row].songID)
        if song.uuid != ""{
            let url = song.img
            cell.img.image = UIImage(named: url)
            cell.lbl.text = song.title
            cell.durationLbl.text = song.length
            cell.countLbl.text = String(format: "%d",song.number_word)
            cell.lblScore.text = String(format: "%.0f", song.result * 100) + "%"
        }
        cell.delegate = self
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let favorite = favorites[indexPath.row]
        let favoriteDB = FavoriteDataManager.shareInstance.findFistFavoriteDbByID(favorite.songID)
        if favoriteDB.songID != ""{
            FavoriteDataManager.shareInstance.deleteFavoriteRealm(favoriteDB)
            JLToast.makeText("Remove from Favorites", duration: 2).show()
            self.refresh()
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isEditting == true {
            if listCellTap.indexOf(indexPath.row) != nil {
                listCellTap.removeAtIndex(listCellTap.indexOf(indexPath.row)!)
            } else {
                listCellTap.append(indexPath.row)
            }
        } else {
            self.showLoadingHUD()
            tbl.deselectRowAtIndexPath(indexPath, animated: true)
            let dest = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
            let tmp = favorites[indexPath.row]
            let songDB = SongDataManager.shareInstance.findFistSongDbByID(tmp.songID)
            let song = Song(songDb: songDB)
            dest.currentSong = song
            dest.titleTab = song.title
            self.presentViewController(dest, animated: true) {
                self.hideLoadingHUD()
            }
        }
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        listCellTap.removeAtIndex(listCellTap.indexOf(indexPath.row)!)
    }
}
extension FavoriteViewController : UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 2:
            let dest = self.storyboard?.instantiateViewControllerWithIdentifier("PlayListViewController") as! PlayListViewController
            let currentSongID = currentFavorite?.songID
            dest.uuidSong = currentSongID
            dest.isFromOther = true
            self.presentViewController(dest, animated: true, completion: {
                
            })
            break
        case 1:
            FavoriteDataManager.shareInstance.deleteFavoriteRealmByUUID((currentFavorite?.songID)!)
            refresh()
            JLToast.makeText("Remove from favorites", duration: 2).show()
            //self.view.makeToast("Remove From Favorites")
        default:
            break
        }
        
    }
}
extension FavoriteViewController : DetailCategoryDelegate {
    func click(cell: DetailCategoryTableViewCell) {
        let number = tbl.indexPathForCell(cell)
        currentFavorite = favorites[number!.row]
        var textToPlaylist = "Remove From Favorite"
        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: textToPlaylist, "Add to Playlist")
        actionSheet.tintColor = UIColor.init(rgba: "#5fb760")
        
        actionSheet.showInView(self.view)
    }
}
