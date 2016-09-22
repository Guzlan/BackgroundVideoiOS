//
//  BackgroundVideo.swift
//
//  Created by Amr Guzlan on 2016-06-25.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

enum BackgroundVideoErrors: Error {
    case invalidVideo
}

class BackgroundVideo {
    // creating an instance of an AVPlayer for background video 
    var backGroundPlayer : AVPlayer?
    var videoURL: URL?
    var viewController: UIViewController?
    var hasBeenUsed: Bool = false
    
    
    init (on viewController: UIViewController, withVideoURL URL: String) {
        self.viewController = viewController
        
        // parse the video string to split it into name and extension
        let videoNameAndExtension:[String]? = URL.characters.split{$0 == "."}.map(String.init)
        if videoNameAndExtension!.count == 2 {
            if let videoName = videoNameAndExtension?[0] , let videoExtension = videoNameAndExtension?[1] {
                if let url = Bundle.main.url(forResource: videoName, withExtension: videoExtension) {
                    self.videoURL = url
                    // initialize our player with our fetched video url
                    self.backGroundPlayer = AVPlayer(url: self.videoURL!)
                } else {
                    print(BackgroundVideoErrors.invalidVideo)
                }
            }
        } else {
            print("Wrong video name format")
        }
    }
    
    
    deinit{
        
        if self.hasBeenUsed {
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
            NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
        }
        
    }
    
    
    /*
     setUpBackground is a function that should be called in viewDidLoad to load a local background video to play as your background
     */
    func setUpBackground(){
        self.backGroundPlayer?.actionAtItemEnd = .none
        self.backGroundPlayer?.isMuted = true // mute the background video....
        
        //add the video to your view ..
        let loginView: UIView = self.viewController!.view//get our view controllers view
        let playerLayer = AVPlayerLayer(player: self.backGroundPlayer)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill // preserve aspect ratio and resize to fill screen
        playerLayer.zPosition = -1 // set it's possition behined anything in our view
        playerLayer.frame = loginView.frame // set our player frame to our view's frame
        loginView.layer.addSublayer(playerLayer)
        
        
        
        // prevent video from disturbing audio services from other apps
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            
        }
        catch {
            print("failed setting AVAudioSession Category to AVAudioSessionCategoryAmbient")
        }
        
        self.backGroundPlayer?.play() // start the video
        
        /// Loop the video when it ends using NSNotifcationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.loopVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        // call the background video again if your application goes to background and foreground again
        NotificationCenter.default.addObserver(self, selector: #selector(self.loopVideo), name: .UIApplicationWillEnterForeground, object: nil)
        self.hasBeenUsed = true
    
    }
    
    // A function that will restarts the video for the purpose of looping
   @objc private func loopVideo() {
        self.backGroundPlayer?.seek(to: kCMTimeZero)
        self.backGroundPlayer?.play()
    }
    
    // incase you want to pause or play the video at any moment
    func pause() {
        self.backGroundPlayer?.pause()

    }
    func play() {
        self.backGroundPlayer?.play()
        
    }
    

}
