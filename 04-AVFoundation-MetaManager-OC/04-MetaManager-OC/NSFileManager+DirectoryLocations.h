//
//  NSFileManager+DirectoryLocations.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (DirectoryLocations)
- (NSString *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                           inDomain:(NSSearchPathDomainMask)domainMask
                appendPathComponent:(NSString *)appendComponent
                              error:(NSError **)errorOut;

- (NSString *)applicationSupportDirectory;
@end

