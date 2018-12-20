//
//  SubtitleViewController.m
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "SubtitleViewController.h"

@interface SubtitleViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *subtitles;
@property (nonatomic, copy) NSString *cellID;
@end

@implementation SubtitleViewController

- (id)initWithSubtitles:(NSArray *)subtitles{
    self = [super initWithNibName:@"SubtitleViewController" bundle:nil];
    if (self) {
        subtitles = subtitles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellID = @"cell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subtitles.count;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID forIndexPath:indexPath];
    NSString *subtitle = self.subtitles[indexPath.row];
    cell.textLabel.text = subtitle;
    if ([subtitle isEqualToString:self.selectedSubtitle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedSubtitle = self.subtitles[indexPath.row];
    [self.tableView reloadData];
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)close:(id)sender{
    [self.delegate subtitleSelected:self.selectedSubtitle];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
