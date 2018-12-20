//
//  PlayerView.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "PlayerView.h"
#import "OverlayView.h"
#import <AVFoundation/AVFoundation.h>
@interface PlayerView()
@property (strong, nonatomic) OverlayView *overlayView;
@end
@implementation PlayerView
+(Class)layerClass{
    return [AVPlayerLayer class];
}

- (id)initWithPlayer:(AVPlayer *)player {
    self = [super initWithFrame:CGRectZero];                                // 3
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth;
        
        [(AVPlayerLayer *) [self layer] setPlayer:player];                  // 4
        
        [[NSBundle mainBundle] loadNibNamed:@"OverlayView"                // 5
                                      owner:self
                                    options:nil];
        
        [self addSubview:_overlayView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.overlayView.frame = self.bounds;
}

- (id <Transport>)transport {
    return self.overlayView;
}
@end
