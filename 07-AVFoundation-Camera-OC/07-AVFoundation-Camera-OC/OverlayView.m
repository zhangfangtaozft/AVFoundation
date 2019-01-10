//
//  OverlayView.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "OverlayView.h"
@interface OverlayView()

@end
@implementation OverlayView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self.modeView addTarget:self action:@selector(modeChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)modeChange:(CameraModeView *)modeView{
    BOOL photoModeEnabled = modeView.cameraMode = CameramodePhoto;
    UIColor *toColor = photoModeEnabled ? [UIColor blackColor] : [UIColor colorWithWhite:0.0f alpha:1.0f];
    CGFloat toOpacity = photoModeEnabled ? 0.0f : 1.0f;
    self.statusView.layer.backgroundColor = toColor.CGColor;
    self.statusView.elapsedTimeLabel.layer.opacity = toOpacity;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self.statusView pointInside:[self convertPoint:point toView:self.statusView] withEvent:event] || [self.modeView pointInside:[self convertPoint:point toView:self.modeView] withEvent:event]) {
        return YES;
    }
    return NO;
}

-(void)setFlashControlHidden:(BOOL) state{
    if (_flashControlHidden != state) {
        _flashControlHidden = state;
        self.statusView.flashControl.hidden = state;
    }
}
@end
