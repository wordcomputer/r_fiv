//
//  Pedometer.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 19/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import CoreMotion

class Pedometer : NSObject {
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    var steps = 0
    
    func startRecord