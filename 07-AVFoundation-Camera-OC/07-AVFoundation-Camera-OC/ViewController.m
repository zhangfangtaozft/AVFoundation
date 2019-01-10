//
//  ViewController.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/7.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "ViewController.h"
#import "FlashControl.h"
#import "CameraView.h"
#import "OverlayView.h"
#import "PreviewView.h"
#import "CameraController.h"
#import "NSTimer+Additions.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()<PreviewViewDelegate>
@property (nonatomic)CameraMode cameraMode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CameraController *cameraController;
@property (weak, nonatomic) IBOutlet PreviewView *previewView;
@property (weak, nonatomic) IBOutlet OverlayView *overlayView;
@property (weak, nonatomic) IBOutlet UIButton *thumbnailButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateThumbnail:) name:ThumbnailCreatedNotification object:nil];
    self.cameraMode = CameraModeVideo;
    self.cameraController = [[CameraController alloc] init];
    NSError *error;
    if ([self.cameraController setupSession:&error]) {
        [self.previewView setSession:self.cameraController.captureSession];
        self.previewView.delegate = self;
        [self.cameraController startSession];
    }else{
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    self.previewView.tapToFocusEnabled = self.cameraController.cameraSupportsTapToFocus;
    self.previewView.tapToExposeEnabled = self.cameraController.cameraSupportsTapToExpose;
}

- (void)updateThumbnail:(NSNotification *)notification{
    UIImage *image = notification.object;
    [self.thumbnailButton setBackgroundImage:image forState:UIControlStateNormal];
    self.thumbnailButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbnailButton.layer.borderWidth = 1.0f;
}

- (AVAudioPlayer *)playerWithResource:(NSString *)resourceName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:resourceName withExtension:@"caf"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.volume = 1.0f;
    return player;
}

- (void)startTimer{
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateTimeDisplay) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimeDisplay {
    CMTime duration = self.cameraController.recordedDuration;
    NSUInteger time = (NSUInteger)CMTimeGetSeconds(duration);
    NSInteger hours = (time / 3600);
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    NSString *format = @"%02i:%02i:%02i";
    NSString *timeString = [NSString stringWithFormat:format,hours,minutes,seconds];
    self.overlayView.statusView.elapsedTimeLabel.text = timeString;
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
    self.overlayView.statusView.elapsedTimeLabel.text = @"00:00:00";
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)tappedToFocusAtPoint:(CGPoint)point{
    [self.cameraController focusAtPoint:point];
}

- (void)tappedToExposeAtPoint:(CGPoint)point {
    [self.cameraController exposeAtPoint:point];
}

- (void)tappedToResetFocusAndExposure{
    [self.cameraController resetFocusAndExposureModes];
}
- (IBAction)flashControlChanged:(id)sender {
    
}

- (IBAction)showCameraRoll:(id)sender {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)cameraModeChanged:(id)sender {
    self.cameraMode = [sender cameraMode];
}
- (IBAction)swapCameras:(id)sender {
    if ([self.cameraController switchCameras]) {
        BOOL hidden = NO;
        if (self.cameraMode == CameramodePhoto) {
            hidden = !self.cameraController.cameraHasFlash;
        } else{
            hidden = !self.cameraController.cameraHasTorch;
        }
        self.overlayView.flashControlHidden = hidden;
        self.previewView.tapToExposeEnabled = self.cameraController.cameraSupportsTapToExpose;
        self.previewView.tapToFocusEnabled = self.cameraController.cameraSupportsTapToFocus;
        [self.cameraController resetFocusAndExposureModes];
    }
}
- (IBAction)captureOrRecord:(UIButton *)sender {
    if (self.cameraMode == CameramodePhoto) {
        [self.cameraController captureStillImage];
    }else{
        if (!self.cameraController.isRecording) {
            dispatch_async(dispatch_queue_create("com.tapharmonic.kamera", NULL), ^{
                [self.cameraController startRecording];
                [self startTimer];
            });
        }else{
            [self.cameraController stopRecording];
            [self stopTimer];
        }
        sender.selected = !sender.selected;
    }
}

@end
