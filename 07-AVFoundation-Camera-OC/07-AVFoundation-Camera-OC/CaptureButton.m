//
//  CaptureButton.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "CaptureButton.h"
#import <QuartzCore/QuartzCore.h>
#define LINE_WIDTH 6.0f
#define DEFAULT_FRAME CGRectMake(0.0f, 0.0f, 68.0f, 68.0f)
@interface PhotoCaptureButton: CaptureButton

@end

@interface videoCaptureButton : PhotoCaptureButton

@end

@interface CaptureButton()
@property (nonatomic, strong) CALayer *circleLayer;

@end
@implementation CaptureButton

+(instancetype) captureButton{
    return [[self alloc] initWithCaptureButtonMode:CaptureButtonModeVideo];
}

+(instancetype)captureButtonWithMode:(CaptureButtonMode)captureButtonMode{
    return [[self alloc] initWithCaptureButtonMode: captureButtonMode];
}

-(id)initWithCaptureButtonMode:(CaptureButtonMode)mode{
    self = [super initWithFrame:DEFAULT_FRAME];
    if (self) {
        _captureButtonMode = mode;
        [self setupView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _captureButtonMode = CaptureButtonModeVideo;
    [self setupView];
}

-(void)setupView{
    self.backgroundColor = [UIColor clearColor];
    self.tintColor = [UIColor clearColor];
    UIColor *circleColor = (self.captureButtonMode == CaptureButtonModeVideo) ? [UIColor redColor] : [UIColor whiteColor];
    _circleLayer = [CALayer layer];
    _circleLayer.backgroundColor = circleColor.CGColor;
    _circleLayer.bounds = CGRectInset(self.bounds, 8.0, 8.0);
    _circleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _circleLayer.cornerRadius = _circleLayer.bounds.size.width / 2.0f;
    [self.layer addSublayer:_circleLayer];
}

-(void)setCaptureButtonMode:(CaptureButtonMode)captureButtonMode{
    if (_captureButtonMode != captureButtonMode) {
        _captureButtonMode = captureButtonMode;
        UIColor *toColor = (captureButtonMode == CaptureButtonModeVideo) ? [UIColor redColor] : [UIColor whiteColor];
        self.circleLayer.backgroundColor = toColor.CGColor;
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    fadeAnimation.duration = 0.2f;
    if (highlighted) {
        fadeAnimation.toValue = @0.0f;
    }else{
        fadeAnimation.toValue = @1.0f;
    }
    self.circleLayer.opacity = [fadeAnimation.toValue floatValue];
    [self.circleLayer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

-(void)selSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.captureButtonMode == CaptureButtonModeVideo) {
        [CATransaction disableActions];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        if (selected) {
            scaleAnimation.toValue = @0.6f;
            radiusAnimation.toValue = @(self.circleLayer.bounds.size.width / 4.0f);
        }else{
            scaleAnimation.toValue = @1.0f;
            scaleAnimation.toValue = @(self.circleLayer.bounds.size.width / 2.0f);
        }
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[scaleAnimation, radiusAnimation];
        animationGroup.beginTime = CACurrentMediaTime() + 0.2f;
        animationGroup.duration = 0.35f;
        [self.circleLayer setValue:radiusAnimation.toValue forKey:@"cornerRadius"];
        [self.circleLayer setValue:scaleAnimation.toValue forKey:@"transform.scale"];
        [self.circleLayer addAnimation:animationGroup forKey:@"scaleAndRadiusAnimation"];
    }
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, LINE_WIDTH);
    CGRect insetRect = CGRectInset(rect, LINE_WIDTH / 2.0f, LINE_WIDTH / 2.0f);
    CGContextStrokeEllipseInRect(context, insetRect);
}


@end
