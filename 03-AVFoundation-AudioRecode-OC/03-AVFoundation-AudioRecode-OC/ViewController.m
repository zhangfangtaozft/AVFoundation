//
//  ViewController.m
//  03-AVFoundation-AudioRecode-OC
//
//  Created by frank.Zhang on 08/03/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightValue;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@property (nonatomic, strong) NSURL *fileUrl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong)AVAudioRecorder *recorder;
@property (nonatomic, strong)AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.bgView.backgroundColor = [UIColor clearColor];
    self.bgView.layer.cornerRadius = 100.0;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.bgView.layer.borderWidth = 2.0;
    self.progressView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];
    self.heightValue.constant = 100.0;
    self.timeLabel.text = @"00:00:00";
    self.msgLabel.text = @"点击左边的按钮开始录音";
}

-(AVAudioRecorder *)recorder{
    if (!_recorder) {
        //获取路径地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:@"zft.caf"];
        self.fileUrl = [NSURL fileURLWithPath:filePath];
        //配置相关参数
        NSMutableDictionary *optionsDict = [NSMutableDictionary dictionary];
        //支持的音频格式
        optionsDict[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
        //采样率
        optionsDict[AVSampleRateKey] = @(44100);
        //通道数
        optionsDict[AVNumberOfChannelsKey] = @(1);
        //线性音频的位深度
        optionsDict[AVLinearPCMBitDepthKey] = @(8);
        //录音的质量
        optionsDict[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityHigh];
        _recorder = [[AVAudioRecorder alloc]initWithURL:self.fileUrl settings:optionsDict error:NULL];
        //是否启用音频测量，默认为NO，一旦启用音频测量可以通过updateMeters方法更新测量值
        _recorder.meteringEnabled = YES;
        //关于录音的一些代理方法都在这里
        _recorder.delegate = self;
        //准备录音，主要用于创建缓冲区，如果不手动调用，在调用record录音时也会自动调用
        [_recorder prepareToRecord];
    }
    return _recorder;
}

-(void)startRecord{
    //录音的时候需要停止之前的播放并且把之前缓存的音频信息全部删除掉
    [self stopPlaying];
    [self clearFile];
    //设置session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error ;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (session != nil) {
        [session setActive:YES error:nil];
    }
    self.session = session;
    [self.recorder record];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateValue) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    self.timer = timer;
}

-(void)updateValue{
    [self.recorder updateMeters];
    float passValue = [self.recorder peakPowerForChannel:0]/110.0 >1 ? 1: [self.recorder peakPowerForChannel:0]/110.0;
    self.heightValue.constant =  passValue * self.bgView.frame.size.height;
     int hourValue = self.recorder.currentTime/3600;
     int minValue = (self.recorder.currentTime - hourValue* 3600)/60;
     int secValue = self.recorder.currentTime - hourValue* 3600 - minValue * 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hourValue,minValue,secValue];
}

-(void)stopRecord{
    [self.recorder isRecording];
    [self.recorder stop];
    [self.timer invalidate];
}

-(void)playRecordFile{
    //播放时需要把录音停止
    [self.recorder stop];
    //如果当前是正在播放状态，就需要返回
    if ([self.player isPlaying]) {
        return;
    }
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:self.fileUrl error:nil];
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}

-(void)stopPlaying{
    [self.player stop];
}

-(void)clearFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (self.fileUrl) {
        [fileManager removeItemAtURL:self.fileUrl error:NULL];
    }
}


- (IBAction)recordAction:(id)sender {
    double currentTime = self.recorder.currentTime;
    if (currentTime < 1.0) {
        self.heightValue.constant = 0.0;
        self.msgLabel.text = @"说话时间太短了";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self stopRecord];
            [self clearFile];
        });
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self stopRecord];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.heightValue.constant = 0.0;
                self.msgLabel.text = @"录音已完成，点击右边按钮可以进行播放。";
            });
        });
    }
}

- (IBAction)playAction:(id)sender {
    [self playRecordFile];
}
- (IBAction)dragExitAction:(id)sender {
    self.heightValue.constant = 0.0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self stopRecord];
        [self clearFile];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.msgLabel.text = @"录音已经被取消";
        });
    });
}

- (IBAction)redordButtonTouchDownAction:(id)sender {
    self.msgLabel.text = @"正在录音中。。。";
    [self startRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
