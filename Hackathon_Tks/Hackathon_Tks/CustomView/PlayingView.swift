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
import MBProgressHUD
import youtube_ios_player_helper
class PlayingView: UIView,YTPlayerViewDelegate {
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblCurentTime: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var sliderProgress: UISlider!
    
    var playerView:YTPlayerView?
    var sliderEditing:Bool?
    var meterTimer:NSTimer?
    var check:NSTimer?
    var currentSong:String?
    override func awakeFromNib() {
        //        self.animate(duration: 0.4, animations: {
        //            self.center.y += -Constant.Systems.screen_size.height
        //            }, completion: nil)
        //initPlayerView()
        sliderEditing = false
        sliderProgress.setThumbImage(UIImage(named: "ic-thumb"), forState: .Normal)
        check = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(checkPlayer), userInfo: nil, repeats: true)
        showLoadingHUD()
    }
    
    //MARK: Play youtube
    func initPlayerView(videoID:String){
        playerView = YTPlayerView()
        self.playerView!.delegate = self
        let playerVars = ["playsinline": 1,"autohide":0,"autoplay" :1]
        // if currentSong != nil{
        playerView!.loadWithVideoId(videoID, playerVars: playerVars)
       // playerView?.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        self.addSubview(playerView!)
    }
    
    @IBAction func btnPlayTouchUp(sender: AnyObject) {
        // playerView!.playVideo()
            if btnPlay.selected{
                print("play")
                btnPlay.selected = false
                    playerView!.playVideo()
                let duration : CMTime = CMTimeMake(Int64(self.playerView!.duration()),1)
                let seconds : Float64 = CMTimeGetSeconds(duration)
                sliderProgress.maximumValue = Float(Int(Float(seconds))) - 1
                sliderProgress.continuous = true
                sliderProgress.tintColor = UIColor.greenColor()
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
    
    //var i = 0
    func UpdateSlider(){
        if lblCurentTime.text != lblDuration.text{
            if playerView != nil{
                if sliderEditing == false {
                    sliderProgress.value = Float(Int(Float(playerView!.currentTime())))
                    lblCurentTime.text = self.formatTime(CGFloat(Int(Float(playerView!.currentTime())))) as String
                    //                print(i)
                    //                i = i + 1
                    
                }
            }
        }else{
            sliderProgress.value = 0
           playerView!.seekToSeconds(0, allowSeekAhead: true)
            lblCurentTime.text = "00:00"
            playerView?.pauseVideo()
            btnPlay.selected = true
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
        btnPlay.selected = false
        playerView!.playVideo()
    }
    
    @IBAction func btnPreviousTouchUp(sender: AnyObject) {
        if playerView?.currentTime() != 0{
            var timeCurent = Float(playerView!.currentTime())
            if timeCurent <= 5.0 {
                timeCurent = 0
            }else{
                timeCurent = timeCurent - 5.0
            }
            playerView!.seekToSeconds(timeCurent, allowSeekAhead: true)
            self.UpdateSlider()
        }
    }
    
    @IBAction func btnNextTouchUp(sender: AnyObject) {
        if playerView?.currentTime() != 0{
            var timeCurent = Float(Int(Float(playerView!.currentTime())))
            if Float(playerView!.duration()) - timeCurent <= 5.0 {
                timeCurent = Float(Int(Float(playerView!.duration())))
            }else{
                timeCurent = timeCurent + 5.0
                
            }
            playerView!.seekToSeconds(timeCurent, allowSeekAhead: true)
         //   meterTimer?.invalidate()
            self.UpdateSlider()
            
        }
    }
    
    func checkPlayer(){
        if playerView?.duration() != 0{
            btnPlay.selected = true
            check?.invalidate()
            hideLoadingHUD()
        }
    }
    //MARK: youtubeAPI Delegate
    func playerView(playerView: YTPlayerView, didChangeToState state: YTPlayerState) {
        switch (state) {
        case YTPlayerState.Unstarted:
            print("")
            
        break
        case YTPlayerState.Playing:
            self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(UpdateSlider), userInfo: nil, repeats: true)
            lblDuration.text = self.formatTime(CGFloat(self.playerView!.duration())) as String
            
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
    
    func showLoadingHUD() {
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(self, animated: true)
    }
}
