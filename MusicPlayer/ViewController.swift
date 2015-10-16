//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Anil on 25/06/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var counter = 0
    var song = ["1","2","3"]
    var player = AVAudioPlayer()
    
    @IBOutlet weak var musicSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicSlider.value = 0.0
    }
    
    func updateMusicSlider(){
        
        musicSlider.value = Float(player.currentTime)
    }

    @IBAction func playSong(sender: AnyObject) {
        
        music()
    }
    @IBAction func sliderAction(sender: AnyObject) {
        
        player.stop()
        player.currentTime = NSTimeInterval(musicSlider.value)
        player.play()
    }
    
    func music(){
        
        let audioPath = NSBundle.mainBundle().pathForResource("\(song[counter])", ofType: "mp3")!
        var error : NSError? = nil
        do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(string: audioPath)!)
        } catch let error1 as NSError {
            error = error1
        }
        musicSlider.maximumValue = Float(player.duration)
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("updateMusicSlider"), userInfo: nil, repeats: true)
        player.delegate = self
        if error == nil {
            player.delegate = self
            player.prepareToPlay()
            player.play()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool){

        if flag {
            counter++
        }
        
        if ((counter + 1) == song.count) {
            counter = 0
        }
        
        music()
    }
}

