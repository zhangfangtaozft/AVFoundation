//
//  ViewController.swift
//  03-AVFoundation-AudioRecord-Swift
//
//  Created by frank.Zhang on 13/03/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var heightValue: NSLayoutConstraint!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    var fileUrl:URL?
    var timer:Timer?
    var session:AVAudioSession?
    var player:AVAudioPlayer?
    var audioSession = AVAudioSession.sharedInstance()
    lazy var recorder: AVAudioRecorder = {
            let path: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask, true)[0] as String
            let filepath:String = path.appending("zft.caf")
            self.fileUrl = URL(fileURLWithPath: filepath)
            let optionDic : NSMutableDictionary = NSMutableDictionary.init()
            optionDic[AVFormatIDKey] = (kAudioFormatAppleIMA4)
            optionDic[AVSampleRateKey] = (44100)
            optionDic[AVNumberOfChannelsKey] = (1)
            optionDic[AVLinearPCMBitDepthKey] = (8)
            optionDic[AVEncoderAudioQualityKey] = NSNumber.init(value: AVAudioQuality.high.rawValue)
            let  audioRecoder : AVAudioRecorder =  try! AVAudioRecorder.init(url:self.fileUrl!, settings: optionDic as! [String : Any])
            audioRecoder.isMeteringEnabled = true
            audioRecoder.prepareToRecord()
            return audioRecoder
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.bgView.backgroundColor = UIColor.clear
        self.bgView.layer.cornerRadius = 100.0
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.borderWidth = 2.0
        self.bgView.layer.borderColor = UIColor.white.cgColor
       self.progressView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.heightValue.constant = 100.0
        self.timeLabel.text = "00:00:00"
        self.msgLabel.text = "点击左边的按钮开始录音"
    }
    
   
    func startRecord(){
        //录音的时候需要停止之前的播放并且把之前缓存的音频信息全部删除掉
        stopPlaying()
        clearFile()
        //设置session
        let session : AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try  session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError{
            print(error)
            do{
                try  session.setActive(true)
            }catch let error as NSError{
                print(error)
            }
        }
        self.session = session
        self.recorder.record()
        let timer : Timer = Timer.init(timeInterval: 0.5, target: self, selector: #selector(updateValue), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
        timer.fire()
        self.timer = timer
    }
    
    @objc func updateValue(){
        self.recorder.updateMeters()
        var passValue: CGFloat = CGFloat((self.recorder.peakPower(forChannel: 0)))/110.0
        if passValue > 1 {
            passValue = 1
        }
        self.heightValue.constant = passValue * self.bgView.frame.size.height
        let hourValue: Int = Int(Double(self.recorder.currentTime)/Double(3600.0))
        let minValue: Int = Int((Double(self.recorder.currentTime) - Double(hourValue) * 3600.00) / 60.0)
        let secValue: Int  = Int((self.recorder.currentTime) - Double(hourValue) * 3600.00 - Double(minValue) * 60.00)
        self.timeLabel.text = String.init(format: "%02d:%02d:%02d", hourValue,minValue,secValue)
    }
    
    func stopRecord(){
        self.recorder.stop()
        self.timer?.invalidate()
    }
    
    func playRecordFile(){
     //播放时需要把录音停止
        self.recorder.stop()
    //如果当前是正在播放状态，就需要返回
        if self.player?.isPlaying ?? false {
            return
        }
        do{
        self.player = try AVAudioPlayer.init(contentsOf: self.fileUrl!)
        try self.session?.setCategory(AVAudioSessionCategoryPlayback)
        self.player?.play()
        } catch let error as NSError{
            print(error)
        }
    }
    
    func stopPlaying(){
     self.player?.stop()
    }
    
    func clearFile(){
        let fileManager :FileManager = FileManager.default
        if (self.fileUrl != nil) {
            do{
            try fileManager.removeItem(at: self.fileUrl!)
            }catch let error as NSError{
                print(error)
            }
        }
    }
    
    @IBAction func redordButtonTouchDownAction(_ sender: Any) {
        self.msgLabel.text = "正在录音中。。。"
        startRecord()
    }
    
    @IBAction func dragExitAction(_ sender: Any) {
        self.heightValue.constant = 0.0
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.msgLabel.text = "录音已经被取消"
            }
        }
    }
    
    @IBAction func recordAction(_ sender: Any) {
        let currentTime: Double = self.recorder.currentTime
        if currentTime < 1.0 {
            self.heightValue.constant = 0.0
            self.msgLabel.text = "说话时间太短了"
            DispatchQueue.global().async {
                self.stopRecord()
                self.clearFile()
            }
        }else{
            DispatchQueue.global().async {
                self.stopRecord()
                DispatchQueue.main.async {
                    self.heightValue.constant = 0.0
                    self.msgLabel.text = "录音已完成，点击右边按钮可以进行播放。"
                }
            }
        }
    }
    
    @IBAction func playAction(_ sender: Any) {
        playRecordFile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

