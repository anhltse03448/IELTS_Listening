//
//  SearchViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import JLToast

class SearchViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var viewNil : UIView!
    var listSong = [Song]()
    var realm : Realm?
    
    var isAddToFavorite : Bool = false
    var currentSongID : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        
        try! realm = Realm()

    }
    func doneClicked(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func initViewController() {
        tbl.showsVerticalScrollIndicator = false
        tbl.tableFooterView = UIView(frame: CGRectZero)
        viewNil.hidden = false
        //customizeSearchTextField()
    }
    
    func cancelTap(gesture : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
//        contentView.bringSubviewToFront(tbl)
//        tbl?.hidden = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //self.textFieldDidChange(self.searchTextField)
        return true
    }
}
extension SearchViewController : UITableViewDataSource , UITableViewDelegate {
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
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tbl.deselectRowAtIndexPath(indexPath, animated: true)
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        dest.currentSong = listSong[indexPath.row]
        dest.titleTab = listSong[indexPath.row].title
        self.presentViewController(dest, animated: true) { 
            
        }
    }
}

extension SearchViewController : DetailCategoryDelegate {
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

extension SearchViewController : UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        switch buttonIndex {
        case 2:
            let dest = self.storyboard?.instantiateViewControllerWithIdentifier("PlayListViewController") as! PlayListViewController
            dest.uuidSong = currentSongID
            dest.isFromOther = true
            self.presentViewController(dest, animated: true, completion: {
                
            })
            break
        case 1:
            if isAddToFavorite {
                var favorite = Favorite()
                favorite.songID = currentSongID!
                FavoriteDataManager.shareInstance.insertFavoriteRealm(favorite)
                JLToast.makeText("Add to Favorites", duration: 1)
                //self.view.toastViewForMessage("", title: "", image: UIImage(named: "recycle"), style: nil)
                //self.view.makeToast("Add To Favorites")
            } else {
                FavoriteDataManager.shareInstance.deleteFavoriteRealmByUUID(currentSongID!)
                JLToast.makeText("Remove From Favorites", duration: 1)
                //self.view.makeToast("Remove From Favorites")
            }
        default:
            break
            
        }
        
    }
}
extension SearchViewController : UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        let result = realm?.objects(SongDB).filter("title CONTAINS[c] %@",searchText).sorted("title")
        listSong.removeAll()
        if result != nil {
            for item in result! {
                listSong.append(Song(songDb: item))
            }
        }
        if listSong.count != 0 {
            viewNil.hidden = true
        } else {
            viewNil.hidden = false
        }
        tbl.reloadData()

    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
    }
}