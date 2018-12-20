//
//  NSTimer+Additions.h
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^TimerFireBlock)(void);
@interface NSTimer (Additions)
+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval firing:(TimerFireBlock)fireBlock;
+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeating:(BOOL)repeat firing:(TimerFireBlock)fireBlock;
@end

