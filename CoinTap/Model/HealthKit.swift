
//
//  HealthKit.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 19/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import HealthKit
import HealthKitUI

protocol HealthKitDelegate {
    func caloryCount()
}

class HealthKit : NSObject {
    
    static let instance = HealthKit()
    var delegate : HealthKitDelegate?
    var height : Double = 170
    var weight : Double = 70
    
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        //2. Prepare the data types that will interact with HealthKit
        guard
            let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass)
             else {
                return
        }
        //3. Prepare a list of types you want HealthKit to read and write
        let healthKitTypesToRead: Set<HKObjectType> = [bodyMassIndex, height, bodyMass]
        
        //4. Request Authorization
        HKHealthStore().requestAuthorization(toShare: nil,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
    }
    
    func getHealthData(for sampleType: HKSampleType,
                      completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void){
        //1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                            
                                            //2. Always dispatch to the main thread when complete.
                                            DispatchQueue.main.async {