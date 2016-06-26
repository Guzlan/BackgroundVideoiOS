//
//  BackgroundVideoObjC.h
//  BackgroundVideoDemo
//
//  Created by Adam Albarghouthi on 2016-06-26.
//  Copyright © 2016 backgroundVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum BackgroundVideoErrors {
    InvalidVideo
} ErrorType;

@interface BackgroundVideoObjC : NSObject

@property (strong, nonatomic) AVPlayer *backgroundPlayer;
@property (strong, nonatomic) NSURL *videoURL;
@property (weak, nonatomic) UIViewController *viewController;

- (void)initOnViewController:(UIViewController *)onViewController withVideoURL:(NSURL *)url;
- (void)setUpBackground;

- (void)pause;
- (void)play;

@end
