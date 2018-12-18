//
//  MetadataConverterFactory.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "DefaultMetadataConverter.h"
#import "MetadataConverter.h"
@interface MetadataConverterFactory : DefaultMetadataConverter
- (id <MetadataConverter>)converterForKey:(NSString *)key;
@end

