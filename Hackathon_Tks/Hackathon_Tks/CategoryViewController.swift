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
    @IBOutlet weak var viewTop : UIView!
    var listCategory = [CategoryObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("\(Realm.Configuration.defaultConfiguration.fileURL)")
        
        tbl.showsVerticalScrollIndicator = false
        InitData.initType()
        tbl.separatorStyle = .None
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
            listCategory.append(CategoryObject(uuid: item.uuid, title: item.title, img: item.img))
        }
        self.tbl.reloadData()
    }
}
extension CategoryViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count / 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("CategoryTableViewCell") as! CategoryTableViewCell
        cell.lbl.text = listCategory[indexPath.row * 2].title
        cell.img.image = UIImage(named: listCategory[indexPath.row * 2].img)
        
        cell.lbl2.text = listCategory[indexPath.row * 2 + 1].title
        cell.img2.image = UIImage(named: listCategory[indexPath.row * 2 + 1].img)
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tbl.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.width / 2
    }
}
extension CategoryViewController : CategoryProtocol {
    func tap(cell: CategoryTableViewCell, index: Int) {
        let number = tbl.indexPathForCell(cell)
        
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("DetailCategoryViewController") as! DetailCategoryViewController
        let item = listCategory[(number?.row)! * 2 + index]
        dest.idCategory = item.uuid
        dest.titleView = item.title
        
        self.navigationController?.pushViewController(dest, animated: true)
    }
}