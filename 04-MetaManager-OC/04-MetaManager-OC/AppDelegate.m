//
//  AppDelegate.m
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"
#import "NSFileManager+DirectoryLocations.h"
//#import "NSFileManager+DirectoryLocations.h"
@interface AppDelegate ()
@property (strong) MainWindowController *controller;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self copyMediaItems];
    _controller = [[MainWindowController alloc] init];
    [_controller showWindow:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)copyMediaItems {
    NSString *appSupport = [[NSFileManager defaultManager] applicationSupportDirectory];
    NSURL *rootURL = [NSURL fileURLWithPath:appSupport];
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:rootURL
                                                      includingPropertiesForKeys:nil
                                                                         options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                           error:nil];
    if (contents.count == 0) {
        NSArray *items = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:@"Media"];
        [items enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
            NSString *filePath = [appSupport stringByAppendingPathComponent:[path lastPathComponent]];
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            NSError *error;
            BOOL result = [[NSFileManager defaultManager] copyItemAtPath:path toPath:filePath error:&error];
            if (!result) {
                NSLog(@"Error %@", [error localizedDescription]);
            }
        }];
    }
}

- (IBAction)resetMediaItems:(id)sender {
    NSString *appSupport = [[NSFileManager defaultManager] applicationSupportDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:appSupport error:nil];
    [self copyMediaItems];
    [self.controller reloadData];
}

@end
