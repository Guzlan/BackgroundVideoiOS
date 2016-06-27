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

@interface BackgroundVideoObjC : NSObject {
    NSURL *videoURL;
    UIViewController *viewController;
}

@property (strong, nonatomic) AVPlayer *backgroundPlayer;

- (id)initOnViewController:(UIViewController *)onViewController withVideoURL:(NSString *)url;

- (void)pause;
- (void)play;

@end
