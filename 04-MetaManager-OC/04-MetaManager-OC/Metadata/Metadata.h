//
//  Metadata.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
@class Genre;
@interface Metadata : NSObject
@property (copy) NSString *name;
@property (copy) NSString *artist;
@property (copy) NSString *albumArtist;
@property (copy) NSString *album;
@property (copy) NSString *grouping;
@property (copy) NSString *composer;
@property (copy) NSString *comments;
@property (strong) NSImage *artwork;
@property (strong) Genre *genre;

@property NSString *year;
@property NSNumber *bpm;
@property NSNumber *trackNumber;
@property NSNumber *trackCount;
@property NSNumber *discNumber;
@property NSNumber *discCount;

- (void)addMetadataItem:(AVMetadataItem *)item withKey:(id)key;

- (NSArray *)metadataItems;
@end
