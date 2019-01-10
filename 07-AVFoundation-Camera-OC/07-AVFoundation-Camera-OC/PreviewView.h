//
//  PreviewView.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol PreviewViewDelegate <NSObject>
- (void)tappedToFocusAtPoint:(CGPoint)point;
- (void)tappedToExposeAtPoint:(CGPoint)point;
- (void)tappedToResetFocusAndExposure;
@end

@interface PreviewView : UIView
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) id<PreviewViewDelegate> delegate;
@property (nonatomic) BOOL tapToFocusEnabled;
@property (nonatomic) BOOL tapToExposeEnabled;
@end

