//
//  ViewController.h
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *localPlaybackButton;
@property (weak, nonatomic) IBOutlet UIButton *remotePlaybackButton;

@property (weak, nonatomic) IBOutlet UILabel *remoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *localLabel;
@end

