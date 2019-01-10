//
//  StatusView.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "FlashControl.h"

@interface StatusView : UIView<FlashControlDelegate>
@property (nonatomic, weak) IBOutlet FlashControl *flashControl;
@property (nonatomic, weak) IBOutlet UILabel *elapsedTimeLabel;
@end

