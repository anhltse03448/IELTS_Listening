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
    var FONT_SIZE : CGFloat = 19
    var viewAnswers : UIView?
    var currentTargetLabel : MyLabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = Utils.readFile("data1")
        let arrStr = Utils.seperateWord(str)
        SIZE_WIDTH = UIScreen.mainScreen().bounds.size.width - 8
        var currentLength : CGFloat = 0
        var previousLeft : UILabel?
        var previousTop : UILabel?
        content = UIView()
        content.userInteractionEnabled = true
        content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.labelTap(_:))))
        var listLabel = [UILabel]()
        for i in arrStr {
            let number = arrStr.indexOf(i)
            
            let lbl = MyLabel()
            
            lbl.text = " " + i.content + " "
            lbl.font = lbl.font.fontWithSize(FONT_SIZE)
            lbl.sizeToFit()
            lbl.textAlignment = .Center
            if i.answer != nil {
                lbl.setAnswers(i.answer!)
                lbl.cornerRadius = 5
                lbl.clipsToBounds = true
                lbl.snp_makeConstraints(closure: { (make) in
                    make.width.equalTo(150)
                })
            }
            if i.answer != nil {
                lbl.backgroundColor = UIColor(rgba: "#eeac57")
            }
            lbl.userInteractionEnabled = true
            lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.labelTap(_:))))
        
            content.addSubview(lbl)
            listLabel.append(lbl)
            sizeHeight = lbl.frame.height
            
            if currentLength + lbl.frame.width < SIZE_WIDTH {
                currentLength = currentLength + lbl.frame.width
                if previousLeft == nil {
                    if previousTop == nil {
                        lbl.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo(content).offset(8)
                            make.left.equalTo(content.snp_left).offset(4)
                        })
                    } else {
                        lbl.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo((previousTop?.snp_bottom)!).offset(8)
                            make.left.equalTo((previousTop?.snp_left)!)
                        })
                    }
                } else {
                    lbl.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo((previousLeft?.snp_top)!)
                        make.left.equalTo((previousLeft?.snp_right)!)
                    })
                }
                previousLeft = lbl
                if number == 0 {
                    previousTop = lbl
                }
            } else {
                countLine = countLine + 1
                currentLength = lbl.frame.width
                previousLeft = nil
                if previousLeft == nil {
                    if previousTop == nil {
                        lbl.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo(content).offset(8)
                            make.left.equalTo(content.snp_left).offset(4)
                        })
                    } else {
                        lbl.snp_makeConstraints(closure: { (make) in
                            make.top.equalTo((previousTop?.snp_bottom)!).offset(8)
                            make.left.equalTo((previousTop?.snp_left)!)
                        })
                    }
                } else {
                    lbl.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo((previousLeft?.snp_top)!)
                        make.left.equalTo((previousLeft?.snp_right)!)
                    })
                }
                previousLeft = lbl
                previousTop = lbl
            }
        }
        self.scrollView.addSubview(content)
    }
    func labelTap (gesture : UITapGestureRecognizer){
        currentTargetLabel = nil
        if self.viewAnswers != nil {
            for subview in (self.viewAnswers?.subviews)! {
                subview.removeFromSuperview()
            }
            self.viewAnswers?.removeFromSuperview()
            self.view.layoutIfNeeded()
        }
        let lbl = gesture.view as? MyLabel
        if lbl != nil {
            currentTargetLabel = lbl
            let text = lbl?.text?.stringByReplacingOccurrencesOfString(" ", withString: "")
            if lbl?.type == 1 {
                if self.viewAnswers == nil {
                    self.viewAnswers = UIView()
                }
                lbl?.backgroundColor = UIColor.init(rgba: "#d38426")
                
                viewAnswers?.cornerRadius = 5
                viewAnswers?.borderColor = UIColor.init(rgba: "#c5c5c5")
                viewAnswers?.borderWidth = 1
                
                
                self.content.addSubview(viewAnswers!)
                viewAnswers!.backgroundColor = UIColor.whiteColor()
                viewAnswers!.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo((lbl?.snp_bottom)!).offset(4)
                    make.left.equalTo((lbl?.snp_left)!)
                    make.width.equalTo((lbl?.snp_width)!)
                    make.height.equalTo(100)
                })
                
                self.view.layoutIfNeeded()
                
                for item in (lbl?.answer)! {
                    let lblAnswer = UILabel()
                    let pos = lbl?.answer.indexOf(item)
                    lblAnswer.tag = pos!
                    lblAnswer.textAlignment = .Center
                    lblAnswer.text = item
                    lblAnswer.font = lblAnswer.font.fontWithSize(12)                    
                    viewAnswers?.addSubview(lblAnswer)
                    lblAnswer.userInteractionEnabled = true
                    lblAnswer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.answerTap(_:))))
                    lblAnswer.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo(viewAnswers!).offset(25 * pos!)
                        make.left.equalTo(viewAnswers!)
                        make.right.equalTo(viewAnswers!)
                        make.height.equalTo(25)
                    })
                }
            }
        }
    }
    
    func answerTap(gesture : UITapGestureRecognizer) {
        let lbl = gesture.view as? UILabel
        if lbl != nil {
            currentTargetLabel?.text = lbl?.text
            self.viewAnswers?.removeFromSuperview()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(countLine) * (sizeHeight + 8))
        //content.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        content.frame.size = CGSize(width: self.view.frame.width, height: CGFloat(countLine) * (sizeHeight + 8))
    }
}