//
//  ViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/11/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //@IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var content : UIView!
    var SIZE_WIDTH : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = "Just tried it on xcode 7.3. In order for this CGRectMake() to take effect, the UIView (my view is actually a subclassed from UIView) needs to have View->Mode set to 'Redraw' or 'Scale to Fit' and the CGRectMake() needs to be in my subclass' drawRect() method. Otherwise the size definitions in the storyboard will take effect. – rockhammer Jul 13 at 14:42 "
        let arrStr = Utils.seperateWord(str)
        SIZE_WIDTH = UIScreen.mainScreen().bounds.size.width
        var currentLength : CGFloat = 0
        var previousLeft : UIView?
        var previousTop : UIView?
        for i in arrStr {
            let number = arrStr.indexOf(i)
            
            
            let tmpView = UIView()
            let lbl = UILabel()
            lbl.text = i
            lbl.font = lbl.font.fontWithSize(20)
            lbl.sizeToFit()
            
            tmpView.addSubview(lbl)
            lbl.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(tmpView)
                make.centerY.equalTo(tmpView)
            })
            content.addSubview(tmpView)
            
            tmpView.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(lbl.snp_width).offset(4)
                make.height.equalTo(lbl.snp_height).offset(4)
            })
            
            
            tmpView.layoutIfNeeded()
            
            
            if currentLength + tmpView.frame.width < SIZE_WIDTH {
                currentLength = currentLength + tmpView.frame.width
                if previousLeft == nil {
                    if previousTop == nil {
                        tmpView.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo(content)
                            make.left.equalTo(content.snp_left)
                        })
                    } else {
                        tmpView.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo((previousTop?.snp_bottom)!)
                            make.left.equalTo((previousTop?.snp_left)!)
                        })
                    }
                } else {
                    tmpView.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo((previousLeft?.snp_top)!)
                        make.left.equalTo((previousLeft?.snp_right)!)
                    })
                }
                previousLeft = tmpView
                if number == 0 {
                    previousTop = tmpView
                }
            } else {
                currentLength = tmpView.frame.width
                previousLeft = nil
                if previousLeft == nil {
                    if previousTop == nil {
                        tmpView.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo(content)
                            make.left.equalTo(content.snp_left)
                        })
                    } else {
                        tmpView.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo((previousTop?.snp_bottom)!)
                            make.left.equalTo((previousTop?.snp_left)!)
                        })
                    }
                } else {
                    tmpView.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo((previousLeft?.snp_top)!)
                        make.left.equalTo((previousLeft?.snp_right)!)
                    })
                }
                previousLeft = tmpView
                previousTop = tmpView
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}

