//
//  ArtworkMetadataConverter.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "ArtworkMetadataConverter.h"
#import <AppKit/AppKit.h>
@implementation ArtworkMetadataConverter
- (id)displayValueFromMetadataItem:(AVMetadataItem *)item {
    NSImage *image = nil;
    if ([item.value isKindOfClass:[NSData class]]) {                        // 1
        image = [[NSImage alloc] initWithData:item.dataValue];
    }
    else if ([item.value isKindOfClass:[NSDictionary class]]) {             // 2
        NSDictionary *dict = (NSDictionary *)item.value;
        image = [[NSImage alloc] initWithData:dict[@"data"]];
    }
    return image;
}

- (AVMetadataItem *)metadataItemFromDisplayValue:(id)value
                                withMetadataItem:(AVMetadataItem *)item {
    
    AVMutableMetadataItem *metadataItem = [item mutableCopy];
    
    NSImage *image = (NSImage *)value;
    metadataItem.value = image.TIFFRepresentation;                          // 3
    
    return metadataItem;
}
@end
