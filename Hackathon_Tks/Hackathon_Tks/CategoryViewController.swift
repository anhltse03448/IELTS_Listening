//
//  CategoryViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    var categoryTitle = ["Art and Culture" , "Daily conversation" , "Education" , "IELTS Listening" ,"Joke" ,
                         "Leisure & Entertainment", "Music", "Nature & Environment 8","News","Places",
                         "Science", "Story" , "Technology"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        tbl.tableFooterView = UIView(frame: CGRectZero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension CategoryViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("CategoryTableViewCell") as! CategoryTableViewCell
        cell.lbl.text = categoryTitle[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("DetailCategoryViewController") as! DetailCategoryViewController
        //dest.lblTitle.text = categoryTitle[indexPath.row]
        self.navigationController?.presentViewController(dest, animated: true, completion: { 
            
        })
    }
}
