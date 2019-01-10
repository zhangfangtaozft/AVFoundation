//
//  CameraController.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/9.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
extern NSString *const ThumbnailCreatedNotification;
@protocol CameraControllerDelegate <NSObject>
- (void)deviceConfigurationFailedWithError:(NSError *)error;
- (void)mediaCaptureFailedWithError:(NSError *)error;
- (void)assetLibraryWriteFailedWithError:(NSError *)error;
@end
@interface CameraController : NSObject
@property (nonatomic, weak) id<CameraControllerDelegate> delegate;
@property (nonatomic, strong, readonly) AVCaptureSession *captureSession;

// Session Configuration                                                    // 2
- (BOOL)setupSession:(NSError **)error;
- (void)startSession;
- (void)stopSession;

// Camera Device Support                                                    // 3
- (BOOL)switchCameras;
- (BOOL)canSwitchCameras;
@property (nonatomic, readonly) NSUInteger cameraCount;
@property (nonatomic, readonly) BOOL cameraHasTorch;
@property (nonatomic, readonly) BOOL cameraHasFlash;
@property (nonatomic, readonly) BOOL cameraSupportsTapToFocus;
@property (nonatomic, readonly) BOOL cameraSupportsTapToExpose;
@property (nonatomic) AVCaptureTorchMode torchMode;
@property (nonatomic) AVCaptureFlashMode flashMode;

// Tap to * Methods                                                         // 4
- (void)focusAtPoint:(CGPoint)point;
- (void)exposeAtPoint:(CGPoint)point;
- (void)resetFocusAndExposureModes;

/** Media Capture Methods **/                                               // 5

// Still Image Capture
- (void)captureStillImage;

// Video Recording
- (void)startRecording;
- (void)stopRecording;
- (BOOL)isRecording;
- (CMTime)recordedDuration;
@end

