//
//  FlashControl.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FlashControlDelegate <NSObject>
@optional
- (void)flashControlWillExpand;
- (void)flashControlDidExpand;
- (void)flashControlWillCollapse;
- (void)flashControlDidCollapse;
@end

@interface FlashControl : UIControl
@property (nonatomic) NSInteger selectedMode;
@property (nonatomic, weak) id<FlashControlDelegate> delegate;

@end

