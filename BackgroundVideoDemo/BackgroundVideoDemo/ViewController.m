//
//  ViewController.m
//  BackgroundVideoDemo
//
//  Created by Adam Albarghouthi on 2016-06-26.
//  Copyright © 2016 backgroundVideo. All rights reserved.
//

#import "ViewController.h"
#import "BackgroundVideoObjC.h"

@interface ViewController ()

@property (strong, nonatomic) BackgroundVideoObjC *backgroundVideo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.backgroundVideo = [[BackgroundVideoObjC alloc] initOnViewController:self withVideoURL:[NSURL URLWithString:@"test.mp4"]];
    [self.backgroundVideo setUpBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
