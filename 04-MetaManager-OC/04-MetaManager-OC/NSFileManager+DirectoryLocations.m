//
//  NSFileManager+DirectoryLocations.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "NSFileManager+DirectoryLocations.h"

enum {
    DirectoryLocationErrorNoPathFound,
    DirectoryLocationErrorFileExistsAtLocation
};

NSString *const DirectoryLocationDomain = @"DirectoryLocationDomain";
@implementation NSFileManager (DirectoryLocations)
- (NSString *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                           inDomain:(NSSearchPathDomainMask)domainMask
                appendPathComponent:(NSString *)appendComponent
                              error:(NSError **)errorOut {
    //
    // Search for the path
    //
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         searchPathDirectory,
                                                         domainMask,
                                                         YES);
    if ([paths count] == 0) {
        if (errorOut) {
            NSDictionary *userInfo =
            [NSDictionary dictionaryWithObjectsAndKeys:
             NSLocalizedStringFromTable(
                                        @"No path found for directory in domain.",
                                        @"Errors",
                                        nil),
             NSLocalizedDescriptionKey,
             [NSNumber numberWithInteger:searchPathDirectory],
             @"NSSearchPathDirectory",
             [NSNumber numberWithInteger:domainMask],
             @"NSSearchPathDomainMask",
             nil];
            *errorOut =
            [NSError
             errorWithDomain:DirectoryLocationDomain
             code:DirectoryLocationErrorNoPathFound
             userInfo:userInfo];
        }
        return nil;
    }
    
    //
    // Normally only need the first path returned
    //
    NSString *resolvedPath = [paths objectAtIndex:0];
    
    //
    // Append the extra path component
    //
    if (appendComponent) {
        resolvedPath = [resolvedPath
                        stringByAppendingPathComponent:appendComponent];
    }
    
    //
    // Create the path if it doesn't exist
    //
    NSError *error = nil;
    BOOL success = [self
                    createDirectoryAtPath:resolvedPath
                    withIntermediateDirectories:YES
                    attributes:nil
                    error:&error];
    if (!success) {
        if (errorOut) {
            *errorOut = error;
        }
        return nil;
    }
    
    //
    // If we've made it this far, we have a success
    //
    if (errorOut) {
        *errorOut = nil;
    }
    return resolvedPath;
}

//
// applicationSupportDirectory
//
// Returns the path to the applicationSupportDirectory (creating it if it doesn't
// exist).
//
- (NSString *)applicationSupportDirectory {
    NSString *executableName =
    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
    NSError *error;
    NSString *result =
    [self
     findOrCreateDirectory:NSApplicationSupportDirectory
     inDomain:NSUserDomainMask
     appendPathComponent:executableName
     error:&error];
    if (!result) {
        NSLog(@"Unable to find or create application support directory:\n%@", error);
    }
    return result;
}
@end
