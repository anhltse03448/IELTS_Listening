//
//  ViewController.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/11/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import SnapKit
import CoreMedia
import youtube_ios_player_helper
import Realm
import RealmSwift
import STPopup

class TestViewController : BaseViewController,YTPlayerViewDelegate {

    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblShowMyScore : UILabel!
    @IBOutlet weak var viewShowMyScore : UIView!
    
    @IBOutlet weak var backView : UIView!

    @IBOutlet weak var btnNextVideo: UIButton!
    
    @IBOutlet weak var tbnPlayVideo: UIButton!
    
    @IBOutlet weak var btnPre: UIButton!
    
    @IBOutlet weak var playSlider: UISlider!
    
    @IBOutlet weak var img_favorite : UIImageView!
    
     var meterTimer:NSTimer?
    var duration : NSTimer?
    var seconds : Float64?
    
    var listLabel = [MyLabel]()
    @IBOutlet weak var playerView: UIView!
    var currentSong : Song?
    var titleTab : String?
    var countLine : Int = 1
    var sizeHeight : CGFloat = 0
    var content : UIView!
    var SIZE_WIDTH : CGFloat = 0
    var FONT_SIZE : CGFloat = 19
    var viewAnswers : UIView?
    var currentTargetLabel : MyLabel?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSLog("\(currentSong?.linkYoutube)")
        initPlayerView()
        
        initViewController()
        let str = Utils.readFile((currentSong?.fileSource)!)
        let arrStr = Utils.seperateWord(str)
        SIZE_WIDTH = UIScreen.mainScreen().bounds.size.width - 8
        var currentLength : CGFloat = 0
        var previousLeft : UILabel?
        var previousTop : UILabel?
        content = UIView()
        content.userInteractionEnabled = true
        content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.labelTap(_:))))
        
        for i in arrStr {
            let number = arrStr.indexOf(i)
            if number == arrStr.count - 1 {
                 self.hideLoadingHUD()
            }
            
            let lbl = MyLabel()
            
            lbl.text = " " + i.content + " "
            lbl.font = lbl.font.fontWithSize(FONT_SIZE)
            lbl.sizeToFit()
            lbl.textAlignment = .Center
            if i.answer != nil {
                lbl.frame = CGRect(x: lbl.frame.minX, y: lbl.frame.minY, width: lbl.frame.width, height: lbl.frame.height + 20)
                lbl.layoutIfNeeded()
                lbl.textColor = UIColor.whiteColor()
                lbl.setAnswers(i.answer!)
                lbl.cornerRadius = 5
                lbl.clipsToBounds = true
                lbl.snp_makeConstraints(closure: { (make) in
                    make.width.equalTo(150)
                })
                listLabel.append(lbl)
            }
            if i.answer != nil {
                lbl.backgroundColor = UIColor(rgba: "#eeac57")
            }
            lbl.userInteractionEnabled = true
            lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.labelTap(_:))))
        
            content.addSubview(lbl)
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
    
    func initViewController() {
        self.lblTitle.text = titleTab
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        backImg.userInteractionEnabled = true
        backImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.backTap(_:))))
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.backTap(_:))))
        lblShowMyScore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.checkMyScore(_:))))
        viewShowMyScore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.checkMyScore(_:))))
        img_favorite.userInteractionEnabled = true
        img_favorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.heart_tap(_:))))
    }
    func initPlayerView(){
        let viewPlayer = UIView.loadFromNibNamed("PlayingView") as! PlayingView
        viewPlayer.frame = CGRect(x: 0,y: 64,width: Constant.Systems.screen_size.width,height: 73)
        viewPlayer.initPlayerView(currentSong!.linkYoutube)
        self.view.addSubview(viewPlayer)
    }
    func backTap(gesture : UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true) { 
            
        }
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
            if lbl?.type == 1 {
                if self.viewAnswers == nil {
                    self.viewAnswers = UIView()
                }
                
                viewAnswers?.cornerRadius = 5
                viewAnswers?.borderColor = UIColor.init(rgba: "#c5c5c5")
                viewAnswers?.borderWidth = 1
                
                self.content.addSubview(viewAnswers!)
                viewAnswers!.backgroundColor = UIColor.whiteColor()
                var ok = false
                if (lbl?.frame.maxY)! + 150 > scrollView.frame.maxY {
                    ok = false
                } else {
                    ok = true
                }
                if ok == true { //bottom
                    viewAnswers!.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo((lbl?.snp_bottom)!).offset(4)
                        make.left.equalTo((lbl?.snp_left)!)
                        make.width.equalTo((lbl?.snp_width)!)
                        make.height.equalTo(150)
                    })
                } else { //top
                    viewAnswers!.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo((lbl?.snp_top)!).offset(-154)
                        make.left.equalTo((lbl?.snp_left)!)
                        make.width.equalTo((lbl?.snp_width)!)
                        make.height.equalTo(150)
                    })
                }
                
                
                self.view.layoutIfNeeded()
                
                let order = Utils.random()
                
                for item in (lbl?.answer)! {
                    let lblAnswer = UILabel()
                    let pos = lbl?.answer.indexOf(item)
                    lblAnswer.tag = pos!
                    lblAnswer.textAlignment = .Center
                    lblAnswer.text = item
                    lblAnswer.font = lblAnswer.font.fontWithSize(20)
                    viewAnswers?.addSubview(lblAnswer)
                    lblAnswer.userInteractionEnabled = true
                    lblAnswer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TestViewController.answerTap(_:))))
                    lblAnswer.snp_makeConstraints(closure: { (make) in
                        make.top.equalTo(viewAnswers!).offset(37 * order[pos!])
                        make.left.equalTo(viewAnswers!)
                        make.right.equalTo(viewAnswers!)
                        make.height.equalTo(37)
                    })
                }
            }
        }
    }
    
    func answerTap(gesture : UITapGestureRecognizer) {
        let lbl = gesture.view as? UILabel
        if lbl != nil {
            currentTargetLabel?.backgroundColor = UIColor.init(rgba: "#377bb5")
            currentTargetLabel?.textColor = UIColor.whiteColor()
            currentTargetLabel?.text = lbl?.text
            if gesture.view?.tag == 0 {
                self.currentTargetLabel?.isTrue = true
            } else {
                self.currentTargetLabel?.isTrue = false
            }
            self.viewAnswers?.removeFromSuperview()
        }
    }
    
    
    func checkMyScore(gesture : UITapGestureRecognizer) {
        var count = 0
        for item in listLabel {
            if item.isTrue == true {
                item.backgroundColor = GREEN_COLOR
                count += 1
            } else {
                item.backgroundColor = RED_COLOR
            }
        }
        self.showResultViewController(listLabel.count, number_true_answer: count)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(countLine) * (sizeHeight + 8 ))
        //content.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        content.frame.size = CGSize(width: self.view.frame.width, height: CGFloat(countLine) * (sizeHeight + 8))
    }
    
    func showMyScore(gesture : UITapGestureRecognizer){
        NSLog("Show me score")
    }
    
    func heart_tap(gesture : UITapGestureRecognizer){
        if Utils.checkIsFavorite((currentSong?.uuid)!) == true {
            img_favorite.image = UIImage(named: "heart_white")
        } else {
            img_favorite.image = UIImage(named: "heart_red")
        }
        
    }
    
    func showResultViewController(total : Int, number_true_answer : Int){
        let resultViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        resultViewController.total = total
        resultViewController.count_true_answer = number_true_answer
        //update Result
        
        let res = Double(number_true_answer) / Double(total)
        
//        if currentSong?.result < res {//update
//            let realm = try! Realm()
//            currentSong?.result = res
//            let result = realm.objects(Song.self).filter(" uuid = %@", (currentSong?.uuid)!)
//            if result.count != 0 {
//                let song = result[0]
//                try! realm.write({ 
//                    song.result = res
//                })
//            }
//        }
        
        let popupController = STPopupController(rootViewController: resultViewController)
        
        popupController.presentInViewController(self)
    }
    
}
extension TestViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.viewAnswers != nil {
            for subview in (self.viewAnswers?.subviews)! {
                subview.removeFromSuperview()
            }
            self.viewAnswers?.removeFromSuperview()
            self.view.layoutIfNeeded()
        }
    }
}