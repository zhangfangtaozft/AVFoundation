//
//  PlayerView.h
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transport.h"

@class AVPlayer;
@interface PlayerView : UIView
-(id)initWithPlayer:(AVPlayer *)player;
@property (nonatomic, readonly) id <Transport> transport;
@end

