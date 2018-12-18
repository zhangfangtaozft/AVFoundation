//
//  MetadataConverter.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@protocol MetadataConverter <NSObject>
- (id)displayValueFromMetadataItem:(AVMetadataItem *)item;

- (AVMetadataItem *)metadataItemFromDisplayValue:(id)value
                                withMetadataItem:(AVMetadataItem *)item;
@end
