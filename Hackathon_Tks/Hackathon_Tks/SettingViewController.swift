//
//  SettingViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/12/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: BaseViewController , MFMailComposeViewControllerDelegate {
    @IBOutlet weak var tbl : UITableView!
    var listLabel : [String] = ["Share this app" , "Rate app" , "Feedback"]
    var icon : [String] = ["Share" , "Rate_app" , "Feed_back"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.showsVerticalScrollIndicator = false
        tbl.tableFooterView = UIView(frame: CGRectZero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
extension SettingViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCellWithIdentifier("SettingTableViewCell") as! SettingTableViewCell
        cell.lblTitle.text = listLabel[indexPath.row]
        cell.img.image = UIImage(named: icon[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tbl.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0 {
            let textToShare = "Hackathon đại chiến Techkids. Tại 24 Hoàng Quốc Việt"
            
            if let myWebsite = NSURL(string: "https://www.facebook.com/groups/950822398341574/?fref=ts") {
                let objectsToShare = [textToShare, myWebsite]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                self.presentViewController(activityVC, animated: true, completion: nil)
            }
        } else if indexPath.row == 1{
            UIApplication.sharedApplication().openURL(NSURL(string : "https://itunes.apple.com/us/app/itunes-connect/id376771144?mt=8")!)
        } else {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["anhltse.fpt@gmail.com"])
            mailVC.setSubject("About IELTS LISTENING")
            mailVC.setMessageBody("I have a problem about your App", isHTML: false)
            presentViewController(mailVC, animated: true, completion: nil)
        }
    }
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
}
