//
//  ImageCropView.swift
//  Ladacu
//
//  Created by IchIT on 10/5/16.
//  Copyright © 2016 TouchSpace. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import youtube_ios_player_helper
class PlayingView: UIView,YTPlayerViewDelegate {
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblCurentTime: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var sliderProgress: UISlider!
    
    var playerView:YTPlayerView?
    var sliderEditing:Bool?
    var meterTimer:NSTimer?
//    var duration : NSTimer?
//    var seconds : Float64?
    var currentSong:String?
    override func awakeFromNib() {
        //        self.animate(duration: 0.4, animations: {
        //            self.center.y += -Constant.Systems.screen_size.height
        //            }, completion: nil)
        initPlayerView()
        sliderEditing = false
        btnPlay.selected = true
    }
    
    //MARK: Play youtube
    func initPlayerView(){
        playerView = YTPlayerView()
        self.playerView!.delegate = self
        let playerVars = ["playsinline": 1,"autohide":0]
        // if currentSong != nil{
        playerView!.loadWithVideoId("Rqk-JqaAg1w", playerVars: playerVars)
        playerView?.playVideo()
        
    }
    
    @IBAction func btnPlayTouchUp(sender: AnyObject) {
            if btnPlay.selected{
                print("play")
                btnPlay.selected = false
                playerView!.playVideo()
            }else{
                self.playerPause()
                print("pause")
            }
    }
    
    func playerPause(){
        self.btnPlay.selected = true
        self.playerView?.pauseVideo()
        self.meterTimer?.invalidate()
    }
    var i = 0
    func UpdateSlider(sender:AnyObject){
        if playerView != nil{
            if sliderEditing == false {
                sliderProgress.value = Float(self.playerView!.currentTime())
                lblCurentTime.text = self.formatTime(CGFloat(self.playerView!.currentTime())) as String
                print(i)
                i = i + 1
            }
        }else{
            sliderProgress.value = 0
            meterTimer?.invalidate()
        }
        
    }
    @IBAction func sliderProgressValueChanged(sender: AnyObject) {
        let newProgress:Float = self.sliderProgress.value
        let newPercentage:Float = newProgress / (self.sliderProgress.maximumValue - self.sliderProgress.minimumValue)
        let seekToTime = Float64(newPercentage) * CMTimeGetSeconds(CMTimeMake(Int64(playerView!.duration()),1))
        playerView!.seekToSeconds(Float(seekToTime), allowSeekAhead: true)
    }
    
    @IBAction func sliderProgressTouchDow(sender: AnyObject) {
        sliderEditing = true
        playerView!.pauseVideo()
    }
    
    @IBAction func sliderProgressTouchUp(sender: AnyObject) {
        sliderEditing = false
        playerView!.playVideo()
    }
    
    @IBAction func btnPreviousTouchUp(sender: AnyObject) {
        print("asdasd")
    }
    
    @IBAction func btnNextTouchUp(sender: AnyObject) {
        let timeCurent = Float(playerView!.currentTime()) + 5.0
        playerView!.seekToSeconds(timeCurent, allowSeekAhead: false)
        
    }
    
    //MARK: youtubeAPI Delegate
    func playerView(playerView: YTPlayerView, didChangeToState state: YTPlayerState) {
        switch (state) {
//        case YTPlayerState.Unstarted:
//            
//            break
        case YTPlayerState.Playing:
            self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(UpdateSlider), userInfo: nil, repeats: true)
            lblDuration.text = self.formatTime(CGFloat(self.playerView!.duration())) as String
            let duration : CMTime = CMTimeMake(Int64(self.playerView!.duration()),1)
            let seconds : Float64 = CMTimeGetSeconds(duration)
            sliderProgress.minimumValue = 0
            sliderProgress.maximumValue = Float(seconds)
            sliderProgress.continuous = true
            sliderProgress.tintColor = UIColor.greenColor()
            break
        case YTPlayerState.Paused:
            self.meterTimer?.invalidate()
            break
        case YTPlayerState.Ended:
            refreshPlayer()
            //playerView.pauseVideo()
        default:
            break;
        }
    }
    
    func refreshPlayer(){
        meterTimer?.invalidate()
        sliderProgress.value = 0
        btnPlay.selected = true
        lblCurentTime.text = "00:00"
        
    }
    
    func formatTime(time:CGFloat) ->NSString{
        let hours:NSInteger = NSInteger(time) / 3600
        let seconds:NSInteger = NSInteger(time) % 60
        let minutes:NSInteger = (NSInteger(time) - NSInteger(hours) * 3600 - seconds) / 60
        return NSString(format:"%02ld:%02ld",minutes,seconds)
    }
}
