//
//  UIView+Additions.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (CGFloat)frameX{
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)frameX{
    self.frame = CGRectMake(frameX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY{
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)frameY{
    self.frame = CGRectMake(self.frame.origin.x, frameY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth{
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)frameWidth{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameWidth);
}

- (CGFloat)frameHeight{
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)frameHeight{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
}


- (CGPoint)frameOrigin{
    return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)frameOrigin{
    self.frame = CGRectMake(frameOrigin.x, frameOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize{
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)frameSize{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameSize.width, frameSize.height);
}

- (CGFloat)boundsX{
    return self.bounds.origin.x;
}

- (void)setBoundsX:(CGFloat)boundsX{
    self.bounds = CGRectMake(boundsX, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)boundsY{
    return self.bounds.origin.y;
}

- (void)setBoundsY:(CGFloat)boundsY{
    self.bounds = CGRectMake(self.bounds.origin.x, boundsY, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)boundsWidth{
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)boundsWidth{
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, boundsWidth, self.bounds.size.height);
}

- (CGFloat)boundsHeight{
    return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)boundsHeight{
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

- (UIImage *)toImage{
    return [self toImageWithSize:self.bounds.size];
}

-(UIImage *)toImageWithSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImageView *)toImageView {
    return [self toImageViewWithSize:self.bounds.size];
}

- (UIImageView *)toImageViewWithSize:(CGSize)size {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self toImageWithSize:size]];
    imageView.frame = CGRectMake(self.frameX, self.frameY, size.width, size.height);
    return imageView;
}
@end
