//
//  ViewController.swift
//  02-AVFoundation-AudioLooper-Swift
//
//  Created by frank.Zhang on 07/03/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    var isPlaying: Bool = true
    var guitarPlayer:AVAudioPlayer?
    var bassPlayer:AVAudioPlayer?
    var drumsPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playButton.setTitle("pause", for: .normal)
        initlayers()
        
    }
    
    func initlayers(){
        guitarPlayer = playerForFile(name: "guitar")
        bassPlayer = playerForFile(name: "bass")
        drumsPlayer = playerForFile(name: "drums")
    }
    
    func playerForFile(name:String)->AVAudioPlayer{
        let url:URL = Bundle.main.url(forResource: name, withExtension: "caf")!
        let player = try? AVAudioPlayer.init(contentsOf: url)
        if player == nil {
            print("Error creating player")
        }
        else{
            //无限循环播放
            player?.numberOfLoops = -1
            //是否允许调整播放速率
            player?.enableRate = true
            //通过预加载其缓冲区播放视频
            player? .prepareToPlay()
        }
        return player!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func firstPan(_ sender: UISlider) {
        let panValue = sender.value*2 - 1.0
        guitarPlayer?.pan = panValue
    }
    
    @IBAction func firstVolume(_ sender: UISlider) {
        let volumeValue = sender.value
        guitarPlayer?.volume = volumeValue
        
    }
    
    @IBAction func secondPan(_ sender: UISlider) {
        let panValue = sender.value*2 - 1.0
        bassPlayer?.pan = panValue
    }
    
    @IBAction func secondVolume(_ sender: UISlider) {
        let volumeValue = sender.value
        bassPlayer?.volume = volumeValue
    }
    
    @IBAction func thirdPan(_ sender: UISlider) {
        let panValue = sender.value*2 - 1.0
        drumsPlayer?.pan = panValue
    }
    
    @IBAction func thirdVolume(_ sender: UISlider) {
        let volumeValue = sender.value
        drumsPlayer?.volume = volumeValue
    }
    
    @IBAction func fourthRate(_ sender: UISlider) {
        let rateValue = sender.value*4
        guitarPlayer?.rate = rateValue
        bassPlayer?.rate = rateValue
        drumsPlayer?.rate = rateValue
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        if isPlaying {
            playButton.setTitle("pause", for: .normal)
            let delayTime = (self.guitarPlayer?.deviceCurrentTime)! + 0.01
            guitarPlayer?.play(atTime: delayTime)
            bassPlayer?.play(atTime: delayTime)
            drumsPlayer?.play(atTime: delayTime)
        }
        else{
            playButton.setTitle("play", for: .normal)
            stop(player: guitarPlayer!)
            stop(player: bassPlayer!)
            stop(player: drumsPlayer!)
        }
        isPlaying = !isPlaying
    }
    
    func stop(player:AVAudioPlayer){
        player.stop()
        player.currentTime = 0.0
    }
}

