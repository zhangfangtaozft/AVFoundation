//
//  CameraView.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/8.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "CameraView.h"
@interface CameraView ()
@property (nonatomic, weak) IBOutlet PreviewView *previewView;
@property (nonatomic, weak) IBOutlet OverlayView *controlsView;
@end

@implementation CameraView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor blackColor];
}
@end
