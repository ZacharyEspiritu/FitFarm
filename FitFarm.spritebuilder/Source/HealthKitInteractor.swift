//
//  ProfileViewController.swift
//  HealthKit~Swift
//
//  Created by EdenLi on 2014/9/17.
//  Copyright (c) 2014年 Darktt Personal Company. All rights reserved.
//

import HealthKit

class HealthKitInteractor {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    static let sharedInstance = HealthKitInteractor()
    
    var healthStore: HKHealthStore?
    var heartRateUnit: HKUnit?
    var delegate: HealthKitInteractorProtocol?
    
    func initHKData() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            healthStore?.requestAuthorizationToShareTypes([HKObjectType.quantityTypeForIdentifier("HKQuantityTypeIdentifierStepCount")!], readTypes:[HKObjectType.quantityTypeForIdentifier("HKQuantityTypeIdentifierStepCount")!], completion: { success, error in
                if success {
                    print("success")
                }
                else {
                    print("noo")
                }
            })
            if #available(iOS 8.2, *) {
                healthStore?.preferredUnitsForQuantityTypes([HKObjectType.quantityTypeForIdentifier("HKQuantityTypeIdentifierStepCount")!], completion: { preferredUnits, error in
                    self.heartRateUnit = preferredUnits[HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!]
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func getSamples()
    {
        let stepCount = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        let sort = [
            NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        ]
        let sampleQuery = HKSampleQuery(sampleType: stepCount!, predicate: nil, limit: 1, sortDescriptors: sort, resultsHandler: { [unowned self] (query, results, error) in
            if let results = results as? [HKQuantitySample]
            {
                let sample = results[0] as HKQuantitySample
                
                let value = sample.quantity.doubleValueForUnit(self.heartRateUnit!)
                print (value)
                let rate = results[0]
                print(results[0])
                print(query)
                self.updateCalorieCount(results)
            }
            })
        healthStore?.executeQuery(sampleQuery)
        
    }
    
    func updateCalorieCount(samples: [HKSample]?)
    {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {return}
        dispatch_async(dispatch_get_main_queue()) {
            guard let sample = heartRateSamples.first else{return}
            let value = sample.quantity.doubleValueForUnit(self.heartRateUnit!)
            print("Steps Walked: " + String(UInt16(value)))
            self.defaults.setInteger(Int(UInt16(value)), forKey: "Steps Walked")
            let date = sample.startDate
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            print(dateFormatter.stringFromDate(date))
            self.delegate?.didAccessNewStepData(self, newSteps: Int(UInt16(value)))
        }
    }
}

protocol HealthKitInteractorProtocol {
    func didAccessNewStepData(healthStore: HealthKitInteractor, newSteps: Int)
}