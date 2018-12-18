//
//  DiscMetadataConverter.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "DiscMetadataConverter.h"
#import "MetadataKeys.h"

@implementation DiscMetadataConverter
- (id)displayValueFromMetadataItem:(AVMetadataItem *)item {
    
    NSNumber *number = nil;
    NSNumber *count = nil;
    
    if ([item.value isKindOfClass:[NSString class]]) {                      // 1
        NSArray *components =
        [item.stringValue componentsSeparatedByString:@"/"];
        number = @([components[0] integerValue]);
        count = @([components[1] integerValue]);
    }
    else if ([item.value isKindOfClass:[NSData class]]) {                   // 2
        NSData *data = item.dataValue;
        if (data.length == 6) {
            uint16_t *values = (uint16_t *)[data bytes];
            if (values[1] > 0) {
                number = @(CFSwapInt16BigToHost(values[1]));                // 3
            }
            if (values[2] > 0) {
                count = @(CFSwapInt16BigToHost(values[2]));                 // 4
            }
        }
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];           // 5
    [dict setObject:number ?: [NSNull null] forKey:MetadataKeyDiscNumber];
    [dict setObject:count ?: [NSNull null] forKey:MetadataKeyDiscCount];
    
    return dict;
}

- (AVMetadataItem *)metadataItemFromDisplayValue:(id)value
                                withMetadataItem:(AVMetadataItem *)item {
    
    AVMutableMetadataItem *metadataItem = [item mutableCopy];
    
    NSDictionary *discData = (NSDictionary *)value;
    NSNumber *discNumber = discData[MetadataKeyDiscNumber];
    NSNumber *discCount = discData[MetadataKeyDiscCount];
    
    uint16_t values[3] = {0};                                                 // 6
    
    if (discNumber && ![discNumber isKindOfClass:[NSNull class]]) {
        values[1] = CFSwapInt16HostToBig([discNumber unsignedIntValue]);    // 7
    }
    
    if (discCount && ![discCount isKindOfClass:[NSNull class]]) {
        values[2] = CFSwapInt16HostToBig([discCount unsignedIntValue]);     // 8
    }
    
    size_t length = sizeof(values);
    metadataItem.value = [NSData dataWithBytes:values length:length];       // 9
    
    return metadataItem;
}
@end
