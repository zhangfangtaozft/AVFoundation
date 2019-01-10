//
//  NSFileManager+Additions.h
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/7.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSFileManager (Additions)
- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString;
@end

