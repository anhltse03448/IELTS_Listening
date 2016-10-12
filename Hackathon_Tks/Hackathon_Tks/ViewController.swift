//
//  ViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/11/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    var countLine : Int = 1
    var sizeHeight : CGFloat = 0
    var content : UIView!
    var SIZE_WIDTH : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        content = UIView()
        let str = Utils.readFile("data1")
        NSLog("\(str)")
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
            lbl.font = lbl.font.fontWithSize(12)
            lbl.sizeToFit()
            
            tmpView.addSubview(lbl)
            lbl.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(tmpView)
                make.centerY.equalTo(tmpView)
            })
            content.addSubview(tmpView)
            
            tmpView.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(lbl.snp_width).offset(4)
                make.height.equalTo(lbl.snp_height).offset(8)
            })
            
            tmpView.layoutIfNeeded()
            
            sizeHeight = tmpView.frame.height
            
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
                countLine = countLine + 1
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
        scrollView.addSubview(content)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(countLine) * sizeHeight)
    }
  
}

