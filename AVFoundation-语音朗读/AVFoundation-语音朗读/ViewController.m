//
//  ViewController.m
//  AVFoundation-语音朗读
//
//  Created by frank.Zhang on 06/03/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVSpeechSynthesizerDelegate>
@property(nonatomic,strong) NSArray * strArray;
@property(nonatomic,strong) NSArray *voiceArray;
@property(nonatomic,strong) AVSpeechSynthesizer *synthesizer;
@property (weak, nonatomic) IBOutlet UILabel *speechLabel;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (nonatomic,assign)BOOL isPlay;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strArray =@[@"单车欲问边，",
                     @"属国过居延。",
                     @"征蓬出汉塞，",
                     @"归雁入胡天。",
                     @"大漠孤烟直，",
                     @"长河落日圆，",
                     @"萧关逢候骑，",
                     @"都护在燕然。",
                     @"A solitary carriage to the frontiers bound,",
                     @"An envoy with no retinue around,",
                     @"A drifting leaf from proud Cathy,",
                     @"With geese back north on a hordish day.",
                     @"A smoke hangs straight on the desert vast,",
                     @"A sun sits round on the endless stream.",
                     @"A horseman bows by a fortress passed:",
                     @"The general’s at the north extreme!"];
    self.voiceArray = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"],[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"]];
    self.synthesizer = [[AVSpeechSynthesizer alloc]init];
    self.isPlay = NO;
    [self.controlButton setTitle:@"pause" forState:UIControlStateNormal];
    self.synthesizer.delegate = self;
    for (int i = 0; i < self.strArray.count;  i ++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:self.strArray[i]];
        //需要读的语言
        if (i < 8) {
            utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
        }
        else{
            utterance.voice = self.voiceArray[i%2];
        }
        //语速0.0f~1.0f
        utterance.rate = 0.5f;
        //声音的音调0.5f~2.0f
        utterance.pitchMultiplier = 0.8f;
        //播放下下一句话的时候有多长时间的延迟
        utterance.postUtteranceDelay = 0.1f;
        //上一句之前需要多久
        utterance.preUtteranceDelay = 0.5f;
        //音量
        utterance.volume = 1.0f;
        //开始播放
        [self.synthesizer speakUtterance:utterance];
    }
}
//开始朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didStartSpeechUtterance->%@",utterance.speechString);
}
//结束朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didFinishSpeechUtterance->%@",utterance.speechString);
    
}
//暂停朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didPauseSpeechUtterance->%@",utterance.speechString);
}
//继续朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didContinueSpeechUtterance->%@",utterance.speechString);
}
//取消朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"didCancelSpeechUtterance->%@",utterance.speechString);
}
//将要播放的语音文字
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSLog(@"willSpeakRangeOfSpeechString->characterRange.location = %zd->characterRange.length = %zd->utterance.speechString= %@",characterRange.location,characterRange.length,utterance.speechString);
    self.speechLabel.text = utterance.speechString;
}

- (IBAction)buttonClick:(id)sender {
    self.isPlay = !self.isPlay;
    if (self.isPlay) {
     [self.controlButton setTitle:@"play" forState:UIControlStateNormal];
        [self.synthesizer  pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    else{
     [self.controlButton setTitle:@"pause" forState:UIControlStateNormal];
        [self.synthesizer continueSpeaking];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
