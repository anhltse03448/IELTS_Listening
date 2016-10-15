//
//  DetailCategoryViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Alamofire
import AlamofireImage

class DetailCategoryViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    @IBOutlet weak var back_img : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var backView : UIView!
    var titleView : String?
    var idCategory : String = ""
    var currentSongID : String?
    var isAddToFavorite : Bool = false
    
    var listSong = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        listSong.removeAll()
        loadSongInCategory()
        tbl.tableFooterView = UIView(frame: CGRectZero)
        
        self.navigationController?.navigationBarHidden = true
        back_img.userInteractionEnabled = true
        back_img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryViewController.backTap(_:))))
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryViewController.backTap(_:))))
        
        self.lblTitle.text = titleView
    }
    
    func loadSongInCategory() {
        let realm = try! Realm()
        let listSongDB = realm.objects(SongDB).filter("genreID == %@",self.idCategory ?? "")
        if listSongDB.count != 0 {
            for item in listSongDB {
                listSong.append(Song(songDb: item))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func backTap(gesture : UITapGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
extension DetailCategoryViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSong.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("DetailCategoryTableViewCell") as! DetailCategoryTableViewCell
        
        cell.lbl.text = listSong[indexPath.row].title
        cell.durationLbl.text = listSong[indexPath.row].length
        cell.countLbl.text = "\(listSong[indexPath.row].number_word)"
        cell.lblScore.text =  String(format: "%.0f%", listSong[indexPath.row].result) //"\(listSong[indexPath.row].result)"
        let url = listSong[indexPath.row].img
        cell.img.image = UIImage(named: url)
        
        cell.delegate = self
        
//        Alamofire.request( .GET , url).responseImage { response in
//            if let image = response.result.value {
//                cell.img.image = image
//            }
//        }
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
}
extension DetailCategoryViewController : DetailCategoryDelegate {
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
extension DetailCategoryViewController : UIActionSheetDelegate {
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