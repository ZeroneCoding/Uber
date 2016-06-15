//
//  GuidePage.swift
//  Uber
//
//  Created by 李银 on 16/6/13.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit
import AVFoundation

class GuidePage: FxBasePage {

    @IBOutlet weak var backImageView: UIImageView!
    
    var player:AVPlayer!
    var playerItem:AVPlayerItem!
    var location:FxLocation!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initPlayVideo()
        doAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func doAnimation() {
        
        var name:String?
        var image:UIImage?
        var imagesArray:[UIImage] = []
        
        for index in 0...67 {
            name = "logo-"+String(format: "%03d", index)
            image = UIImage(named: name!)
            imagesArray.insert(image!, atIndex: index)
        }
        
        backImageView?.animationImages = imagesArray
        backImageView?.animationRepeatCount = 1
        backImageView?.animationDuration = 5
        
        backImageView?.startAnimating()
        
        UIView.animateWithDuration(0.7, delay:5, options:.CurveEaseOut, animations: {
            self.backView!.alpha = 1.0
            self.player?.play()
            }, completion: nil)
        
    }
    
    func initPlayVideo() {
        let path = NSBundle.mainBundle().pathForResource("welcome_video", ofType: "mp4")
        let url = NSURL.fileURLWithPath(path!)
        
        playerItem = AVPlayerItem(URL: url)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = backView!.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        
        backView!.layer.insertSublayer(playerLayer, atIndex: 0)
        backView!.alpha = 0.0
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(GuidePage.didFinishVideo(_:)),
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: playerItem)
    }
    
    func didFinishVideo(sender:NSNotification) {
        
        let item = sender.object as! AVPlayerItem
        item.seekToTime(kCMTimeZero)
        self.player.play()
    }
    
    @IBAction func loginBtnClick(sender: UIButton) {
        location = FxLocation()
        
        location.startLocation()
    }
    @IBAction func registerBtnClick(sender: AnyObject) {
//        showIndicator("Test&Verify", autoHide: true, afterDelay: true)
        let page = CreateAccountPage()
        let navPage = UINavigationController(rootViewController: page)
        
        self.presentViewController(navPage, animated: true, completion: nil)
        
    }

}
