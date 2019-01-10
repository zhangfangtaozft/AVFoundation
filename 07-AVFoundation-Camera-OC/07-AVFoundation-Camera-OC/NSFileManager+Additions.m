//
//  NSFileManager+Additions.m
//  07-AVFoundation-Camera-OC
//
//  Created by frank.zhang on 2019/1/7.
//  Copyright © 2019 Frank.zhang. All rights reserved.
//

#import "NSFileManager+Additions.h"

@implementation NSFileManager (Additions)

- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString{
    NSString *mkdTemplate = [NSTemporaryDirectory() stringByAppendingPathComponent:templateString];
    const char *buffer = [mkdTemplate fileSystemRepresentation];
//    char *buffer = templateCString;
    NSString *directoryPath = nil;
    char *result = mkdtemp(buffer);
    if (result) {
        directoryPath = [self stringWithFileSystemRepresentation:buffer length:strlen(result)];
    }
    return directoryPath;
}

@end
