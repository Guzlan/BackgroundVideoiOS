//
//  BackgroundVideoObjC.m
//  BackgroundVideoDemo
//
//  Created by Adam Albarghouthi on 2016-06-26.
//  Copyright © 2016 backgroundVideo. All rights reserved.
//

#import "BackgroundVideoObjC.h"

static BOOL hasBeenUsed = false;

@implementation BackgroundVideoObjC

- (id)initOnViewController:(UIViewController *)onViewController withVideoURL:(NSString *)url {
    self = [super init];
    
    if (self) {
        viewController = onViewController;
        
        // parse the video string to split it into name and extension
        NSArray *videoNameAndExtension = [url componentsSeparatedByString:@"."];
        if (videoNameAndExtension.count == 2) {
            __weak NSString *videoName = videoNameAndExtension[0];
            __weak NSString *videoExtension = videoNameAndExtension[1];
            
            if ([[NSBundle mainBundle] URLForResource:videoName withExtension:videoExtension]) {
                
                videoURL = [[NSBundle mainBundle] URLForResource:videoName withExtension:videoExtension];
                // initialize our player with our fetched video url
                self.backgroundPlayer = [AVPlayer playerWithURL:videoURL];
            }
            else {
                NSLog(@"Invalid Video");
            }
        }
        else {
            NSLog(@"Wrong video name format");
        }
    }
    
    return self;
}

- (void)dealloc {
    if (hasBeenUsed) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    }
}

// setUpBackground is a function that should be called in viewDidLoad to load a local background video to play as your background
- (void)setUpBackground {
    self.backgroundPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    self.backgroundPlayer.muted = true;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.backgroundPlayer];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill; // preserve aspect ratio and resize to fill screen
    playerLayer.zPosition = -1; // set position behind anything in our view
    playerLayer.frame = viewController.view.frame; // set our player frame to our view's frame
    
    [viewController.view.layer addSublayer:playerLayer];
    
    // prevent video from disturbing audio services from other apps
    @try {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    }
    @catch (NSException *exception) {
        // deal with the exception
        NSLog(@"%@", exception.reason);
    }
    @finally {
        // optional block of clean-up code
        // executed whether or not an exception occurred
    }
    
    // start video
    [self.backgroundPlayer play];
    
    // Loop the video when it ends using NSNotifcationCenter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loopVideo)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    // call the background video again if your application goes to background and foreground again
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loopVideo)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    hasBeenUsed = true;
}

// private function
// A function that will restarts the video for the purpose of looping
- (void)loopVideo {
    [self.backgroundPlayer seekToTime:kCMTimeZero];
    [self.backgroundPlayer play];
}

// incase you want to pause or play the video at any moment
- (void)play {
    [self.backgroundPlayer play];
}

- (void)pause {
    [self.backgroundPlayer pause];
}

@end
