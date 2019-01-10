//
//  CameraView.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "PreviewView.h"

@interface CameraView : UIView
@property (nonatomic, weak, readonly) PreviewView *previewView;
@property (nonatomic, weak, readonly) OverlayView *controlsView;
@end

