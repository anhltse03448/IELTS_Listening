//
//  BaseViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showLoadingHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
}
