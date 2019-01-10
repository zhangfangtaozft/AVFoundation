//
//  StatusView.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "StatusView.h"
#include <AVFoundation/AVFoundation.h>
#import "UIView+Addition.h"

@implementation StatusView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupView];
}

-(void)setupView{
    self.flashControl.delegate = self;
}

-(void)flashControlWillExpand {
    [UIView animateWithDuration:0.2f animations:^{
        self.elapsedTimeLabel.alpha = 0.0f;
    }];
}

-(void)flashControlDidCollapse{
    [UIView animateWithDuration:0.1f animations:^{
        self.elapsedTimeLabel.alpha = 1.0f;
    }];
}
@end
