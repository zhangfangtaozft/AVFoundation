//
//  ViewController.h
//  04-MetaManager-OC
//
//  Created by frank.zhang on 2018/12/18.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Metadata/MediaItem.h"

@interface ViewController : NSWindowController<NSTableViewDelegate, NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSProgressIndicator *spinnerView;
@property (weak) IBOutlet NSTextField *nameField;

@property (weak) IBOutlet NSTextField *artistField;
@property (weak) IBOutlet NSTextField *albumArtistField;
@property (weak) IBOutlet NSTextField *albumField;
@property (weak) IBOutlet NSTextField *groupingField;
@property (weak) IBOutlet NSTextField *composerField;
@property (weak) IBOutlet NSTextField *commentsField;
@property (weak) IBOutlet NSComboBox *genreCombo;
@property (weak) IBOutlet NSTextField *yearField;
@property (weak) IBOutlet NSTextField *trackNumberField;
@property (weak) IBOutlet NSTextField *trackCountField;
@property (weak) IBOutlet NSTextField *discNumberField;
@property (weak) IBOutlet NSTextField *discCountField;
@property (weak) IBOutlet NSTextField *bpmField;
@property (weak) IBOutlet NSImageView *imageWell;
@property (weak) IBOutlet NSButton *compilationCheckbox;
@property (weak) IBOutlet NSButton *saveButton;

@property (weak) MediaItem *mediaItem;

- (IBAction)save:(id)sender;

- (void)reloadData;

@end

