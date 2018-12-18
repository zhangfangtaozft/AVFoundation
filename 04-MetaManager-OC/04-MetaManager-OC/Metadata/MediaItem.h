//
//  MediaItem.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Metadata.h"
typedef void(^CompletionHandler)(BOOL complete);

@interface MediaItem : NSObject
@property (strong, readonly) NSString *filename;
@property (strong, readonly) NSString *filetype;
@property (strong, readonly) Metadata *metadata;
@property (readonly, getter = isEditable) BOOL editable;

- (id)initWithURL:(NSURL *)url;

- (void)prepareWithCompletionHandler:(CompletionHandler)handler;

- (void)saveWithCompletionHandler:(CompletionHandler)handler;
@end
