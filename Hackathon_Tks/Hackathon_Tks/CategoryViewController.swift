//
//  CategoryViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage
import Alamofire

class CategoryViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    var listCategory = [CategoryObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitData.initType()
        loadData()
        self.navigationController?.navigationBarHidden = true
        tbl.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadData() {
        let realm = try! Realm()
        let listCategoryDB = realm.objects(Genre.self)
        for item in listCategoryDB {
            listCategory.append(CategoryObject(title: item.title, img: item.img))
            NSLog("\(item.img)")
        }
        self.tbl.reloadData()
    }
}
extension CategoryViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("CategoryTableViewCell") as! CategoryTableViewCell
        cell.lbl.text = listCategory[indexPath.row].title
        cell.img.clipsToBounds = true
        cell.img.image = UIImage(named: listCategory[indexPath.row].img)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("DetailCategoryViewController") as! DetailCategoryViewController
        dest.idCategory = indexPath.row
        tbl.deselectRowAtIndexPath(indexPath, animated: true)
        dest.titleView = listCategory[indexPath.row].title
        
        self.navigationController?.presentViewController(dest, animated: true, completion: { 
            
        })
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
