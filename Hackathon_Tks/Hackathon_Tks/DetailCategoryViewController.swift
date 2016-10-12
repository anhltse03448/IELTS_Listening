//
//  DetailCategoryViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class DetailCategoryViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    @IBOutlet weak var back_img : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        back_img.userInteractionEnabled = true
        back_img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailCategoryViewController.backTap(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func backTap(gesture : UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }

}
extension DetailCategoryViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("DetailCategoryTableViewCell") as! DetailCategoryTableViewCell
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        self.presentViewController(dest, animated: true) { 
            
        }
    }
}
