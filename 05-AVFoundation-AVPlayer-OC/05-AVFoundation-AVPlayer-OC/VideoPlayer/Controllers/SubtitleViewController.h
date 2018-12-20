//
//  SubtitleViewController.h
//  05-AVFoundation-AVPlayer-OC
//
//  Created by frank.zhang on 2018/12/19.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubtitleViewControllerDelegate<NSObject>
- (void)subtitleSelected:(NSString *)subtitle;
@end

@interface SubtitleViewController : UIViewController
- (id)initWithSubtitles:(NSArray *)subtitles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *selectedSubtitle;
@property (weak, nonatomic) id<SubtitleViewControllerDelegate> delegate;
- (IBAction)close:(id)sender;
@end

