//
//  PlayerController.h
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

@interface PlayerController : NSObject
- (id)initWithURL:(NSURL *)assetURL;
@property (strong, nonatomic, readonly) UIView *view;
@end


