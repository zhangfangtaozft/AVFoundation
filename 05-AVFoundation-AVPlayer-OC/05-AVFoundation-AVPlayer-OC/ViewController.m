//
//  ViewController.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "ViewController.h"
#import "YoutubeParser.h"
#import "PlayerViewController.h"
#import "UIAlertView+Additions.h"

#define YOUTUBE_URL @"https://www.youtube.com/watch?v=3tUCuMSPQwE"

#define LOCAL_SEGUE        @"localSegue"
#define STREAMING_SEGUE @"streamingSegue"
@interface ViewController ()
@property (nonatomic, strong) NSURL *localURL;
@property (nonatomic, strong) NSURL *streamingURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.localURL = [[NSBundle mainBundle] URLForResource:@"hubblecast" withExtension:@"m4v"];
    [YoutubeParser h264videosWithYoutubeURL:[NSURL URLWithString:YOUTUBE_URL] completeBlock:^(NSDictionary *videoDictionary, NSError *error) {
        self.streamingURL = [NSURL URLWithString:videoDictionary[@"hd720"]];
    }];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:LOCAL_SEGUE] && !self.localURL) {
        return [self alertError];
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSURL *url = [segue.identifier isEqualToString:LOCAL_SEGUE] ? self.localURL : self.streamingURL;
    PlayerViewController *controller = [segue destinationViewController];
    controller.assesURL = url;
}

-(BOOL)alertError{
    [UIAlertView showAlertWithTitle:@"Asset Unavailable"
                            message:@"The requested asset could not be loaded."];
    return NO;
}

@end
