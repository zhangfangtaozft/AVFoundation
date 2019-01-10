//
//  PreviewView.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "PreviewView.h"
#import "NSTimer+Additions.h"
#define BOX_BOUNDS CGRectMake(0.0f, 0.0f, 150, 150.0f)

@interface PreviewView()
@property (nonatomic, strong) UIView *focusBox;
@property (nonatomic, strong) UIView *exposureBox;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UITapGestureRecognizer *singleTapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *doubleDoubleTapRecognizer;
@end
@implementation PreviewView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void) setupView{
    [(AVCaptureVideoPreviewLayer *)self.layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    _singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    _doubleTapRecognizer.numberOfTapsRequired = 2;
    
    _doubleDoubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleDoubleTap:)];
    _doubleDoubleTapRecognizer.numberOfTapsRequired = 2;
    _doubleDoubleTapRecognizer.numberOfTouchesRequired = 2;
    
    [self addGestureRecognizer:_singleTapRecognizer];
    [self addGestureRecognizer:_doubleTapRecognizer];
    [self addGestureRecognizer:_doubleDoubleTapRecognizer];
    [_singleTapRecognizer requireGestureRecognizerToFail:_doubleTapRecognizer];
    _focusBox = [self viewWithColor:[UIColor colorWithRed:0.102 green:0.636 blue:1.000 alpha:1.000]];
    _exposureBox = [self viewWithColor:[UIColor colorWithRed:1.000 green:0.421 blue:0.054 alpha:1.000]];
    [self addSubview:_focusBox];
    [self addSubview:_exposureBox];
}

-(void)handleSingleTap:(UIGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self];
    [self runBoxAnimationOnView:self.exposureBox point:point];
    if (self.delegate) {
        [self.delegate tappedToFocusAtPoint:[self captureDevicePointForPoint:point]];
    }
}

-(CGPoint)captureDevicePointForPoint:(CGPoint)point{
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    return [layer captureDevicePointOfInterestForPoint:point];
}

-(void)handleDoubleTap:(UIGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self];
    [self runBoxAnimationOnView:self.exposureBox point:point];
    if (self.delegate) {
        [self.delegate tappedToExposeAtPoint:[self captureDevicePointForPoint:point]];
    }
}
-(void)handleDoubleDoubleTap:(UIGestureRecognizer *)recognizer{
    [self runResetAnimation];
    if (self.delegate) {
        [self.delegate tappedToResetFocusAndExposure];
    }
}

-(void)runBoxAnimationOnView:(UIView *)view point:(CGPoint)point{
    view.center = point;
    view.hidden = NO;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    } completion:^(BOOL finished) {
        double delayInSeconds = 0.5f;
        dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(poptime, dispatch_get_main_queue(), ^(void){
            view.hidden = YES;
            view.transform = CGAffineTransformIdentity;
        });
    }];
}

-(void)runResetAnimation {
    if (!self.tapToFocusEnabled &&  !self.tapToFocusEnabled) {
        return;
    }
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    CGPoint centerPoint = [previewLayer pointForCaptureDevicePointOfInterest:CGPointMake(0.5f, 0.5f)];
    self.focusBox.center = centerPoint;
    self.exposureBox.center = centerPoint;
    self.exposureBox.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    self.focusBox.hidden = NO;
    self.exposureBox.hidden = NO;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.focusBox.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
        self.exposureBox.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1.0);
    } completion:^(BOOL finished) {
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.focusBox.hidden = YES;
            self.exposureBox.hidden = YES;
            self.focusBox.transform = CGAffineTransformIdentity;
            self.exposureBox.transform = CGAffineTransformIdentity;
        });
    }];
}

-(void) setTapToFocusEnabled:(BOOL) enabled{
    _tapToFocusEnabled = enabled;
    self.singleTapRecognizer.enabled = enabled;
}

-(void) setTapToExposeEnabled:(BOOL) enabled{
    _tapToFocusEnabled = enabled;
    self.doubleTapRecognizer.enabled = enabled;
}

-(UIView *)viewWithColor:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:BOX_BOUNDS];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor clearColor].CGColor;
    view.layer.borderWidth = 5.0f;
    view.hidden = YES;
    return view;
}

+(Class)layerClass{
    return [AVCaptureVideoPreviewLayer class];
}

-(AVCaptureSession *)session{
    return [(AVCaptureVideoPreviewLayer*)self.layer session];
}

-(void)setSession:(AVCaptureSession *)session{
    [(AVCaptureVideoPreviewLayer *)self.layer setSession:session];
}
@end
