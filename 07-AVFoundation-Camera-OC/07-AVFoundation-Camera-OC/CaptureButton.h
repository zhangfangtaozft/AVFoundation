//
//  CaptureButton.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, CaptureButtonMode){
    CaptureButtonModePhoto = 0,
    CaptureButtonModeVideo = 1
};
@interface CaptureButton : UIButton
+(instancetype)captureButton;
+(instancetype)captureButtonWithMode:(CaptureButtonMode)captureButtonMode;
@property (nonatomic) CaptureButtonMode captureButtonMode;
@end

