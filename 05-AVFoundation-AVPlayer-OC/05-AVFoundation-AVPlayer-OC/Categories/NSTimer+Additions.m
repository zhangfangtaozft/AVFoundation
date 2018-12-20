//
//  NSTimer+Additions.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "NSTimer+Additions.h"

@implementation NSTimer (Additions)
+(void)executeTimerBlock:(NSTimer *)timer{
    TimerFireBlock block = [timer userInfo];
    block();
}



+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval firing:(TimerFireBlock)fireBlock{
    return [self scheduledTimerWithTimeInterval:inTimeInterval repeating:NO firing:fireBlock];
}

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeating:(BOOL)repeat firing:(TimerFireBlock)fireBlock{
    id block = [fireBlock copy];
    return [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeTimerBlock:) userInfo:block repeats:repeat];
}

@end
