//
//  CommentMetadataConverter.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "CommentMetadataConverter.h"

@implementation CommentMetadataConverter
- (id)displayValueFromMetadataItem:(AVMetadataItem *)item {
    
    NSString *value = nil;
    if ([item.value isKindOfClass:[NSString class]]) {                      // 1
        value = item.stringValue;
    }
    else if ([item.value isKindOfClass:[NSDictionary class]]) {             // 2
        NSDictionary *dict = (NSDictionary *) item.value;
        if ([dict[@"identifier"] isEqualToString:@""]) {
            value = dict[@"text"];
        }
    }
    return value;
}

- (AVMetadataItem *)metadataItemFromDisplayValue:(id)value
                                withMetadataItem:(AVMetadataItem *)item {
    
    AVMutableMetadataItem *metadataItem = [item mutableCopy];               // 3
    metadataItem.value = value;
    return metadataItem;
}
@end
