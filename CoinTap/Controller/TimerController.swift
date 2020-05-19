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
        timerLabel.font = UIFont.init(name: "04