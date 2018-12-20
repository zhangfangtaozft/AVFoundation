//
//  Thumbnail.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "Thumbnail.h"

@implementation Thumbnail
+ (instancetype)thumbnailWithImage:(UIImage *)image time:(CMTime)time{
    return [[self alloc] initWithImage:image time:time];
}

-(id)initWithImage:(UIImage *)image time:(CMTime)time{
    self = [super init];
    if (self) {
        _image = image;
        _time = time;
    }
    return self;
}
@end
