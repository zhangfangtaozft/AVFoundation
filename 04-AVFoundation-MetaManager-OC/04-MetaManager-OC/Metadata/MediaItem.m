//
//  MediaItem.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "MediaItem.h"
#import "AVMetadataItem+Additions.h"
#import "NSFileManager+DirectoryLocations.h"

#define COMMON_META_KEY     @"commonMetadata"
#define AVAILABLE_META_KEY  @"availableMetadataFormats"
@interface MediaItem()
@property (strong) NSURL *url;
@property (strong) AVAsset *asset;
@property (strong) Metadata *metadata;
@property (strong) NSArray *acceptedFormats;
@property BOOL prepared;
@end
@implementation MediaItem
- (id)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;                                                         // 1
        _asset = [AVAsset assetWithURL:url];
        _filename = [url lastPathComponent];
        _filetype = [self fileTypeForURL:url];                              // 2
        _editable = ![_filetype isEqualToString:AVFileTypeMPEGLayer3];      // 3
        _acceptedFormats = @[                                               // 4
                             AVMetadataFormatQuickTimeMetadata,
                             AVMetadataFormatiTunesMetadata,
                             AVMetadataFormatID3Metadata
                             ];
    }
    return self;
}

- (NSString *)fileTypeForURL:(NSURL *)url {
    NSString *ext = [[self.url lastPathComponent] pathExtension];
    NSString *type = nil;
    if ([ext isEqualToString:@"m4a"]) {
        type = AVFileTypeAppleM4A;
    } else if ([ext isEqualToString:@"m4v"]) {
        type = AVFileTypeAppleM4V;
    } else if ([ext isEqualToString:@"mov"]) {
        type = AVFileTypeQuickTimeMovie;
    } else if ([ext isEqualToString:@"mp4"]) {
        type = AVFileTypeMPEG4;
    } else {
        type = AVFileTypeMPEGLayer3;
    }
    return type;
}

- (void)prepareWithCompletionHandler:(CompletionHandler)completionHandler {
    
    if (self.prepared) {                                                    // 1
        completionHandler(self.prepared);
        return;
    }
    
    self.metadata = [[Metadata alloc] init];                              // 2
    
    NSArray *keys = @[COMMON_META_KEY, AVAILABLE_META_KEY];
    
    [self.asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        
        AVKeyValueStatus commonStatus =
        [self.asset statusOfValueForKey:COMMON_META_KEY error:nil];
        
        AVKeyValueStatus formatsStatus =
        [self.asset statusOfValueForKey:AVAILABLE_META_KEY error:nil];
        
        self.prepared = (commonStatus == AVKeyValueStatusLoaded) &&         // 3
        (formatsStatus == AVKeyValueStatusLoaded);
        
        if (self.prepared) {
            for (AVMetadataItem *item in self.asset.commonMetadata) {       // 4
                //NSLog(@"%@: %@", item.keyString, item.value);
                [self.metadata addMetadataItem:item withKey:item.commonKey];
            }
            
            for (id format in self.asset.availableMetadataFormats) {        // 5
                if ([self.acceptedFormats containsObject:format]) {
                    NSArray *items = [self.asset metadataForFormat:format];
                    for (AVMetadataItem *item in items) {
                        //NSLog(@"%@: %@", item.keyString, item.value);
                        [self.metadata addMetadataItem:item
                                               withKey:item.keyString];
                    }
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(self.prepared);
        });
        
    }];
}

- (void)saveWithCompletionHandler:(CompletionHandler)handler {
    
    NSString *presetName = AVAssetExportPresetPassthrough;                  // 1
    AVAssetExportSession *session =
    [[AVAssetExportSession alloc] initWithAsset:self.asset
                                     presetName:presetName];
    
    NSURL *outputURL = [self tempURL];                                      // 2
    session.outputURL = outputURL;
    session.outputFileType = self.filetype;
    session.metadata = [self.metadata metadataItems];                       // 3
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        AVAssetExportSessionStatus status = session.status;
        BOOL success = (status == AVAssetExportSessionStatusCompleted);
        if (success) {                                                      // 4
            NSURL *sourceURL = self.url;
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtURL:sourceURL error:nil];
            [manager moveItemAtURL:outputURL toURL:sourceURL error:nil];
            [self reset];                                                   // 5
        }
        
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(success);
            });
        }
    }];
}

- (NSURL *)tempURL {
    NSString *tempDir = NSTemporaryDirectory();
    NSString *ext = [[self.url lastPathComponent] pathExtension];
    NSString *tempName = [NSString stringWithFormat:@"temp.%@", ext];
    NSString *tempPath = [tempDir stringByAppendingPathComponent:tempName];
    return [NSURL fileURLWithPath:tempPath];
}

- (void)reset {
    _prepared = NO;
    _asset = [AVAsset assetWithURL:self.url];
}
@end
