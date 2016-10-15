//
//  FavoriteViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import SDWebImage
class FavoriteViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    var favorites: [Favorite] = [Favorite]()
    @IBOutlet weak var lblEdit : UILabel!
    var isEditting : Bool = false
    var listCellTap = [Int]()

    
    @IBOutlet weak var tbvFavorite: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblEdit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FavoriteViewController.btnTapEdit(_:))))
        tbl.tableFooterView = UIView(frame: CGRectZero)
        tbl.tintColor = GREEN_COLOR
        tbl.showsVerticalScrollIndicator = false
        
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
            cell.img.sd_setImageWithURL(NSURL(string: song.img))
            cell.lbl.text = song.title
            cell.durationLbl.text = song.length
            cell.countLbl.text = String(format: "%d",song.number_word)
        }
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
        }
    }
}
