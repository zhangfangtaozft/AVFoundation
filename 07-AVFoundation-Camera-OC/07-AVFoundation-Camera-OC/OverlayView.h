//
//  OverlayView.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraModeView.h"
#import "StatusView.h"

@interface OverlayView : UIView
@property (nonatomic, weak) IBOutlet CameraModeView *modeView;
@property (nonatomic, weak) IBOutlet StatusView *statusView;
@property (nonatomic, assign) BOOL flashControlHidden;
@end

