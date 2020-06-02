//
//  TimerController.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 19/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func setupTimer(){
        seconds = timeAmount
        timerLabel.isHidden = true
        timerLabel.font = UIFont.init(name: "04b_19", size: labelSize)
    }
    func startTimer(){
        timerLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    @objc func updateTimer(){
        s