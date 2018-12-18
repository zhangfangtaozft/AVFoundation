//
//  AVMetadataItem+Additions.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "AVMetadataItem+Additions.h"

@implementation AVMetadataItem (Additions)
- (NSString *)keyString {
    if ([self.key isKindOfClass:[NSString class]]) {                        // 1
        return (NSString *)self.key;
    }
    else if ([self.key isKindOfClass:[NSNumber class]]) {
        
        UInt32 keyValue = [(NSNumber *) self.key unsignedIntValue];         // 2
        
        // Most, but not all, keys are 4 characters ID3v2.2 keys are
        // only be 3 characters long.  Adjust the length if necessary.
        
        size_t length = sizeof(UInt32);                                     // 3
        if ((keyValue >> 24) == 0) --length;
        if ((keyValue >> 16) == 0) --length;
        if ((keyValue >> 8) == 0) --length;
        if ((keyValue >> 0) == 0) --length;
        
        long address = (unsigned long)&keyValue;
        address += (sizeof(UInt32) - length);
        
        // keys are stored in big-endian format, swap
        keyValue = CFSwapInt32BigToHost(keyValue);                          // 4
        
        char cstring[length];                                               // 5
        strncpy(cstring, (char *) address, length);
        cstring[length] = '\0';
        
        // Replace '©' with '@' to match constants in AVMetadataFormat.h
        if (cstring[0] == '\xA9') {                                         // 6
            cstring[0] = '@';
        }
        
        return [NSString stringWithCString:(char *) cstring                 // 7
                                  encoding:NSUTF8StringEncoding];
        
    }
    else {
        return @"<<unknown>>";
    }
}
@end
