
//
//  MusicPlayer.swift
//  Rain
//
//  Created by Ridwan Abdurrasyid on 18/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import AVFoundation


class MusicPlayer :  NSObject{
    static let instance = MusicPlayer()
    var audioPlayer : AVAudioPlayer?

    func playSound(){
        let sound = Bundle.main.path(forResource: "coin", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        audioPlayer?.prepareToPlay()