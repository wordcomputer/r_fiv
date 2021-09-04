
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
                                                
                                                guard let samples = samples,
                                                    let mostRecentSample = samples.first as? HKQuantitySample else {
                                                        
                                                        completion(nil, error)
                                                        return
                                                }
                                                
                                                completion(mostRecentSample, nil)
                                            }
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    
    func loadHealthData(){
        print(#function, height, weight)
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        getHealthData(for: heightSampleType) { (sample, error) in
            
            guard let sample = sample else { return }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.height = heightInMeters
            self.delegate?.caloryCount()
            print(#function, self.height, self.weight)

        }
        
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        getHealthData(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else { return }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.weight = weightInKilograms
            self.delegate?.caloryCount()
            print(#function, self.height, self.weight)
        }
    }
}