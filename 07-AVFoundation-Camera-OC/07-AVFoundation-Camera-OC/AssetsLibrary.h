//
//  AssetsLibrary.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/9.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsLibrary : NSObject
-(void)writeImage:(UIImage *)image;
-(void)writevideo:(NSURL *)videoURL;
@end

