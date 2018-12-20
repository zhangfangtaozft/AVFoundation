//
//  PlayerViewController.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerController.h"
@interface PlayerViewController ()
@property (nonatomic, strong) PlayerController *controller;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controller = [[PlayerController alloc] initWithURL:self.assesURL];
    UIView *playerView = self.controller.view;
    playerView.frame = self.view.frame;
    [self.view addSubview:playerView];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
