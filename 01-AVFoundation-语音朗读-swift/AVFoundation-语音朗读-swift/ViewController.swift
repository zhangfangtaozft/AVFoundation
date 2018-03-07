//
//  ViewController.swift
//  AVFoundation-语音朗读-swift
//
//  Created by frank.Zhang on 07/03/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    var strArray: [String] = ["单车欲问边，",
                             "属国过居延。",
                             "征蓬出汉塞，",
                             "归雁入胡天。",
                             "大漠孤烟直，",
                             "长河落日圆，",
                             "萧关逢候骑，",
                             "都护在燕然。",
                             "A solitary carriage to the frontiers bound,",
                             "An envoy with no retinue around,",
                             "A drifting leaf from proud Cathy,",
                             "With geese back north on a hordish day.",
                             "A smoke hangs straight on the desert vast,",
                             "A sun sits round on the endless stream.",
                             "A horseman bows by a fortress passed:",
                             "The general’s at the north extreme!"]
    let chineseLanguage: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: "zh-CN")!
    let englishLanguage: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: "en-GB")!
    var synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer.init()
    var isPlay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.synthesizer.delegate = self
        self.controlButton.setTitle("pause", for: .normal)
        for i in 0...self.strArray.count - 1 {
            let utterance: AVSpeechUtterance = AVSpeechUtterance.init(string: self.strArray[i])
            //需要读的语言
            if(i < 8){
                utterance.voice = chineseLanguage
            }
            else{
                utterance.voice = englishLanguage
            }
            //语速0.0f~1.0f
            utterance.rate = 0.5
            //声音的音调0.5f~2.0f
            utterance.pitchMultiplier = 0.8
            //播放下下一句话的时候有多长时间的延迟
            utterance.postUtteranceDelay = 0.1
            //上一句之前需要多久
            utterance.preUtteranceDelay = 0.5
            //音量
            utterance.volume = 1.0
            self.synthesizer.speak(utterance)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClick(_ sender: Any) {
      self.isPlay = !self.isPlay
        if self.isPlay {
            self.controlButton.setTitle("play", for: .normal)
            self.synthesizer.pauseSpeaking(at: .immediate)
        }else{
            self.controlButton.setTitle("pause", for: .normal)
            self.synthesizer.continueSpeaking()
        }
    }
}
extension ViewController: AVSpeechSynthesizerDelegate{
    ////开始朗读的代理方法
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("didStart utterance")
    }
    
    //结束朗读的代理方法
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("didFinish utterance")
    }
    //暂停朗读的代理方法
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("didPause utterance")
    }
    //继续朗读的代理方法
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("didContinue utterance")
    }
    //取消朗读的代理方法
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("didCancel utterance")
    }
    //将要播放的语音文字
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print("willSpeakRangeOfSpeechString")
        self.speechLabel.text = utterance.speechString
    }
}


