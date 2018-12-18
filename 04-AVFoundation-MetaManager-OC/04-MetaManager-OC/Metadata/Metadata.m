//
//  Metadata.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "Metadata.h"
#import "MetadataConverterFactory.h"
#import "MetadataKeys.h"
@interface Metadata ()
@property (strong) NSDictionary *keyMapping;
@property (strong) NSMutableDictionary *metadata;
@property (strong) MetadataConverterFactory *converterFactory;
@end
@implementation Metadata
- (id)init {
    self = [super init];
    if (self) {
        _keyMapping = [self buildKeyMapping];                               // 1
        _metadata = [NSMutableDictionary dictionary];                       // 2
        _converterFactory = [[MetadataConverterFactory alloc] init];      // 3
    }
    return self;
}

- (NSDictionary *)buildKeyMapping {
    
    return @{
             // Name Mapping
             AVMetadataCommonKeyTitle : MetadataKeyName,
             
             // Artist Mapping
             AVMetadataCommonKeyArtist : MetadataKeyArtist,
             AVMetadataQuickTimeMetadataKeyProducer : MetadataKeyArtist,
             
             // Album Artist Mapping
             AVMetadataID3MetadataKeyBand : MetadataKeyAlbumArtist,
             AVMetadataiTunesMetadataKeyAlbumArtist : MetadataKeyAlbumArtist,
             @"TP2" : MetadataKeyAlbumArtist,
             
             // Album Mapping
             AVMetadataCommonKeyAlbumName : MetadataKeyAlbum,
             
             // Artwork Mapping
             AVMetadataCommonKeyArtwork : MetadataKeyArtwork,
             
             // Year Mapping
             AVMetadataCommonKeyCreationDate : MetadataKeyYear,
             AVMetadataID3MetadataKeyYear : MetadataKeyYear,
             @"TYE" : MetadataKeyYear,
             AVMetadataQuickTimeMetadataKeyYear : MetadataKeyYear,
             AVMetadataID3MetadataKeyRecordingTime : MetadataKeyYear,
             
             // BPM Mapping
             AVMetadataiTunesMetadataKeyBeatsPerMin : MetadataKeyBPM,
             AVMetadataID3MetadataKeyBeatsPerMinute : MetadataKeyBPM,
             @"TBP" : MetadataKeyBPM,
             
             // Grouping Mapping
             AVMetadataiTunesMetadataKeyGrouping : MetadataKeyGrouping,
             @"@grp" : MetadataKeyGrouping,
             AVMetadataCommonKeySubject : MetadataKeyGrouping,
             
             // Track Number Mapping
             AVMetadataiTunesMetadataKeyTrackNumber : MetadataKeyTrackNumber,
             AVMetadataID3MetadataKeyTrackNumber : MetadataKeyTrackNumber,
             @"TRK" : MetadataKeyTrackNumber,
             
             // Composer Mapping
             AVMetadataQuickTimeMetadataKeyDirector : MetadataKeyComposer,
             AVMetadataiTunesMetadataKeyComposer : MetadataKeyComposer,
             AVMetadataCommonKeyCreator : MetadataKeyComposer,
             
             // Disc Number Mapping
             AVMetadataiTunesMetadataKeyDiscNumber : MetadataKeyDiscNumber,
             AVMetadataID3MetadataKeyPartOfASet : MetadataKeyDiscNumber,
             @"TPA" : MetadataKeyDiscNumber,
             
             // Comments Mapping
             @"ldes" : MetadataKeyComments,
             AVMetadataCommonKeyDescription : MetadataKeyComments,
             AVMetadataiTunesMetadataKeyUserComment : MetadataKeyComments,
             AVMetadataID3MetadataKeyComments : MetadataKeyComments,
             @"COM" : MetadataKeyComments,
             
             // Genre Mapping
             AVMetadataQuickTimeMetadataKeyGenre : MetadataKeyGenre,
             AVMetadataiTunesMetadataKeyUserGenre : MetadataKeyGenre,
             AVMetadataCommonKeyType : MetadataKeyGenre
             };
}


- (void)addMetadataItem:(AVMetadataItem *)item withKey:(id)key {
    
    NSString *normalizedKey = self.keyMapping[key];                         // 1
    
    if (normalizedKey) {
        
        id <MetadataConverter> converter =                                // 2
        [self.converterFactory converterForKey:normalizedKey];
        
        // Extract the value from the AVMetadataItem instance and
        // convert it into a format suitable for presentation.
        id value = [converter displayValueFromMetadataItem:item];
        
        // Track and Disc numbers/counts are stored as NSDictionary
        if ([value isKindOfClass:[NSDictionary class]]) {                   // 3
            NSDictionary *data = (NSDictionary *) value;
            for (NSString *currentKey in data) {
                if (![data[currentKey] isKindOfClass:[NSNull class]]) {
                    [self setValue:data[currentKey] forKey:currentKey];
                }
            }
        } else {
            [self setValue:value forKey:normalizedKey];
        }
        
        // Store the AVMetadataItem away for later use
        self.metadata[normalizedKey] = item;                                // 4
    }
}

- (NSArray *)metadataItems {
    
    NSMutableArray *items = [NSMutableArray array];                         // 1
    
    // Add track number/count if applicable
    [self addMetadataItemForNumber:self.trackNumber                         // 2
                             count:self.trackCount
                         numberKey:MetadataKeyTrackNumber
                          countKey:MetadataKeyTrackCount
                           toArray:items];
    
    // Add disc number/count if applicable
    [self addMetadataItemForNumber:self.discNumber
                             count:self.discCount
                         numberKey:MetadataKeyDiscNumber
                          countKey:MetadataKeyDiscCount
                           toArray:items];
    
    NSMutableDictionary *metaDict = [self.metadata mutableCopy];            // 6
    [metaDict removeObjectForKey:MetadataKeyTrackNumber];
    [metaDict removeObjectForKey:MetadataKeyDiscNumber];
    
    for (NSString *key in metaDict) {
        
        id <MetadataConverter> converter =
        [self.converterFactory converterForKey:key];
        
        id value = [self valueForKey:key];                                  // 7
        
        AVMetadataItem *item =                                              // 8
        [converter metadataItemFromDisplayValue:value
                               withMetadataItem:metaDict[key]];
        if (item) {
            [items addObject:item];
        }
    }
    
    return items;
}

- (void)addMetadataItemForNumber:(NSNumber *)number
                           count:(NSNumber *)count
                       numberKey:(NSString *)numberKey
                        countKey:(NSString *)countKey
                         toArray:(NSMutableArray *)items {                  // 3
    
    id <MetadataConverter> converter =
    [self.converterFactory converterForKey:numberKey];
    
    NSDictionary *data = @{numberKey : number ?: [NSNull null],             // 4
                           countKey : count ?: [NSNull null]};
    
    AVMetadataItem *sourceItem = self.metadata[numberKey];
    
    AVMetadataItem *item =                                                  // 5
    [converter metadataItemFromDisplayValue:data
                           withMetadataItem:sourceItem];
    if (item) {
        [items addObject:item];
    }
}
@end
