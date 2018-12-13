//
//  SpeechManager.h
//  01_HelloAVF_Starter
//
//  Created by frank.zhang on 2018/12/13.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface SpeechManager : NSObject
@property (strong, nonatomic, readonly) AVSpeechSynthesizer *synthesizer;
+(instancetype)speechManager;
-(void)beginConversation;
@end
