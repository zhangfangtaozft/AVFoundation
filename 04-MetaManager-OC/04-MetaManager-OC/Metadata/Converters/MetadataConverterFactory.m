//
//  MetadataConverterFactory.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "MetadataConverterFactory.h"
#import "ArtworkMetadataConverter.h"
#import "CommentMetadataConverter.h"
#import "DiscMetadataConverter.h"
#import "GenreMetadataConverter.h"
#import "TrackMetadataConverter.h"
#import "MetadataKeys.h"

@implementation MetadataConverterFactory
- (id <MetadataConverter>)converterForKey:(NSString *)key {
    
    id <MetadataConverter> converter = nil;
    
    if ([key isEqualToString:MetadataKeyArtwork]) {
        converter = [[ArtworkMetadataConverter alloc] init];
    }
    else if ([key isEqualToString:MetadataKeyTrackNumber]) {
        converter = [[TrackMetadataConverter alloc] init];
    }
    else if ([key isEqualToString:MetadataKeyDiscNumber]) {
        converter = [[DiscMetadataConverter alloc] init];
    }
    else if ([key isEqualToString:MetadataKeyComments]) {
        converter = [[CommentMetadataConverter alloc] init];
    }
    else if ([key isEqualToString:MetadataKeyGenre]) {
        converter = [[GenreMetadataConverter alloc] init];
    }
    else {
        converter = [[DefaultMetadataConverter alloc] init];
    }
    
    return converter;
}
@end
