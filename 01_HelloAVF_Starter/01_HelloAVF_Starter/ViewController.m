//
//  ViewController.m
//  01_HelloAVF_Starter
//
//  Created by frank.zhang on 2018/12/13.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "ViewController.h"
#import "SpeechManager.h"
#import <AVFoundation/AVFoundation.h>
#import "BubbleCell.h"

@interface ViewController ()<AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) SpeechManager *speechManager;
@property (strong, nonatomic) NSMutableArray *speechStrings;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 20.0f, 0.0f);
    self.speechManager = [SpeechManager speechManager];
    self.speechManager.synthesizer.delegate = self;
    self.speechStrings = [NSMutableArray array];
    [self.speechManager beginConversation];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.speechStrings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = indexPath.row %2 == 0 ? @"rightCell" : @"leftCell";
    BubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.messageLabel.text = self.speechStrings[indexPath.row];
    return cell;
}
#pragma mark - AVSpeechSynthesizerDelegate - 

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self.speechStrings addObject:utterance.speechString];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.speechStrings.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
@end
