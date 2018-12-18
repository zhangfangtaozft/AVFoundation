//
//  NumberFormatter.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "NumberFormatter.h"
@interface NumberFormatter()
@property (strong) NSCharacterSet *digitSet;
@end

@implementation NumberFormatter
- (id)init {
    self = [super init];
    if (self) {
        _digitSet = [NSCharacterSet decimalDigitCharacterSet];
    }
    return self;
}

- (BOOL)isPartialStringValid:(NSString **)partialStringPtr
       proposedSelectedRange:(NSRangePointer)proposedSelRangePtr
              originalString:(NSString *)origString
       originalSelectedRange:(NSRange)origSelRange
            errorDescription:(NSString **)error {
    
    BOOL isValid = [super isPartialStringValid:partialStringPtr
                         proposedSelectedRange:proposedSelRangePtr
                                originalString:origString
                         originalSelectedRange:origSelRange
                              errorDescription:error];
    if (isValid) {
        NSCharacterSet *partialSet =
        [NSCharacterSet characterSetWithCharactersInString:*partialStringPtr];
        if (![self.digitSet isSupersetOfSet:partialSet]) {
            return NO;
        }
    }
    return isValid;
}
@end
