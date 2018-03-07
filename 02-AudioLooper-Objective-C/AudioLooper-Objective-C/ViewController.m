//
//  ViewController.m
//  AudioLooper-Objective-C
//
//  Created by frank.Zhang on 07/03/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *firstPan;
@property (weak, nonatomic) IBOutlet UISlider *firstVolume;
@property (weak, nonatomic) IBOutlet UISlider *secondPan;
@property (weak, nonatomic) IBOutlet UISlider *secondVolume;
@property (weak, nonatomic) IBOutlet UISlider *thirdPan;
@property (weak, nonatomic) IBOutlet UISlider *thirdVolume;
@property (weak, nonatomic) IBOutlet UISlider *fourthVolume;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) AVAudioPlayer *guitarPlayer;
@property (nonatomic, strong) AVAudioPlayer *bassPlayer;
@property (nonatomic, strong) AVAudioPlayer *drumsPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPlaying = YES;
    [self.playButton setTitle:@"pause" forState:UIControlStateNormal];
    [self initPlayes];
}

-(void)initPlayes{
    self.guitarPlayer = [self playerForFile:@"guitar"];
    self.bassPlayer = [self playerForFile:@"bass"];
    self.drumsPlayer = [self playerForFile:@"drums"];
    self.guitarPlayer.delegate = self;
    
}

-(AVAudioPlayer *)playerForFile:(NSString *)name{
    NSURL *fileURL = [[NSBundle mainBundle]URLForResource:name withExtension:@"caf"];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:&error];
    if (player) {
        //无限循环播放
        player.numberOfLoops = -1;
        //是否允许调整播放速率
        player.enableRate = YES;
        //通过预加载其缓冲区播放音频
        [player prepareToPlay];
    }
    else{
    NSLog(@"Error creating player: %@", [error localizedDescription]);
    }
    return  player;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playAction:(id)sender {
    if (self.isPlaying) {
      [self.playButton setTitle:@"pause" forState:UIControlStateNormal];
        NSTimeInterval delayTime = [self.guitarPlayer deviceCurrentTime] + 0.01;
        [self.guitarPlayer playAtTime:delayTime];
        [self.bassPlayer playAtTime:delayTime];
        [self.drumsPlayer playAtTime:delayTime];
    }
    else{
      [self.playButton setTitle:@"play" forState:UIControlStateNormal];
        [self stop:self.guitarPlayer];
        [self stop:self.bassPlayer];
        [self stop:self.drumsPlayer];

    }
    self.isPlaying = !self.isPlaying;
    NSLog(@"playAction");
}

-(void)stop:(AVAudioPlayer *)player{
    [player stop];
    player.currentTime = 0.0f;
}

- (IBAction)firstPan:(UISlider*)sender {
    float panValue = sender.value*2 - 1.0;
    self.guitarPlayer.pan = panValue;
    NSLog(@"firstPan");
}
- (IBAction)firstVolume:(UISlider*)sender {
    self.guitarPlayer.volume = sender.value;
    NSLog(@"firstVolume");
}
- (IBAction)secondPan:(UISlider *)sender {
    self.bassPlayer.pan = sender.value*2 - 1;
    NSLog(@"firstVolume");
}
- (IBAction)secondVolume:(UISlider *)sender {
    self.bassPlayer.volume = sender.value;
    NSLog(@"secondVolume");
}
- (IBAction)thirdPan:(UISlider *)sender {
    self.drumsPlayer.pan = sender.value*2 - 1;
    NSLog(@"thirdPan");
}

- (IBAction)thirdVolume:(UISlider*)sender {
    self.drumsPlayer.volume = sender.value;
    NSLog(@"thirdVolume");
}
- (IBAction)fourthVolume:(UISlider *)sender {
    self.guitarPlayer.rate = sender.value *4;
    self.bassPlayer.rate = sender.value *4;
    self.drumsPlayer.rate = sender.value *4;
    NSLog(@"fourthVolume->%f",self.guitarPlayer.rate);
}

@end
