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
    
    func startRecord(){
        startCountingSteps()
    }
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.steps = Int(pedometerData.numberOfSteps)
            }
        }
    }
    
    func stopRecord(){
        pedometer.stopUpdates()
    }
}
