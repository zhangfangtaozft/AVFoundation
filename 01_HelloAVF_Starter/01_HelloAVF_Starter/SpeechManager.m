//
//  SpeechManager.m
//  01_HelloAVF_Starter
//
//  Created by frank.zhang on 2018/12/13.
//  Copyright © 2018 Frank.zhang. All rights reserved.
//

#import "SpeechManager.h"
#import <AVFoundation/AVFoundation.h>
@interface SpeechManager()
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) NSArray *voices;
@property (strong, nonatomic) NSArray *speechStrings;
@end

@implementation SpeechManager
+ (instancetype)speechManager{
    return [[self alloc] init];
}

-(id)init{
    self = [super init];
    if (self) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        //en-US: 美国(英语)，en-GB英国(英语)
        _voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
        _speechStrings = [self buildSpeechStrings];
    }
    return self;
}

-(NSArray *)buildSpeechStrings{
   return  @[@"Hello AV Foundation. How are you?",
      @"I'm well! Thanks for asking.",
      @"Are you excited about the book?",
      @"Very! I have always felt so misunderstood.",
      @"What's your favorite feature?",
      @"Oh, they're all my babies.  I couldn't possibly choose.",
      @"It was great to speak with you!",
      @"The pleasure was all mine!  Have fun!"];
}

-(void)beginConversation{
    for (NSUInteger i = 0; i < self.speechStrings.count; i++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.speechStrings[i]];
        utterance.voice = self.voices[i % 2];
        utterance.rate = 0.5f;
        utterance.pitchMultiplier = 0.8f;
        utterance.postUtteranceDelay = 0.1f;
        [self.synthesizer speakUtterance:utterance];
    }
}
@end
