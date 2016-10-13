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

class DetailCategoryViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    @IBOutlet weak var back_img : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var backView : UIView!
    var titleView : String?
    var idCategory : Int?
    
    var listSong = [SongObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        listSong.removeAll()
        loadSongInCategory()
        
        self.navigationController?.navigationBarHidden = true
        back_img.userInteractionEnabled = true
        back_img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryViewController.backTap(_:))))
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryViewController.backTap(_:))))
        
        self.lblTitle.text = titleView
    }
    
    func loadSongInCategory() {
        let realm = try! Realm()
        let listSongDB = realm.objects(Genre.self).filter("id == %@", self.idCategory ?? 0)
        if listSongDB.count != 0 {
            for item in listSongDB[0].listSong {
                listSong.append(SongObject(song: item))
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
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.showLoadingHUD()
        tbl.deselectRowAtIndexPath(indexPath, animated: true)
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        dest.currentSong = listSong[indexPath.row]
        dest.titleTab = "ahihi"        
        self.presentViewController(dest, animated: true) { 
            self.hideLoadingHUD()
        }
    }
}
