import Foundation
import HealthKit

class MainScene: CCNode {
    
    var healthStore: HKHealthStore?
    var heartRateUnit: HKUnit?
    
    func didLoadFromCCB() {
        
        if HKHealthStore.isHealthDataAvailable() {
            print("hello")
            healthStore = HKHealthStore()
            healthStore?.requestAuthorizationToShareTypes([HKObjectType.quantityTypeForIdentifier("HKQuantityTypeIdentifierHeartRate")!], readTypes:[HKObjectType.quantityTypeForIdentifier("HKQuantityTypeIdentifierHeartRate")!], completion: { success, error in
                if success {
                    print("success")
                }
                else {
                    print("noo")
                }
            })
            if #available(iOS 8.2, *) {
                healthStore?.preferredUnitsForQuantityTypes([HKObjectType.quantityTypeForIdentifier("HKQuantityTypeIdentifierHeartRate")!], completion: { preferredUnits, error in
                    self.heartRateUnit = preferredUnits[HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!]
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func test() {
        getSamples()
    }
    
    func getSamples()
    {
        let heartrate = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
        let sort = [
            NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        ]
        let heartRateUnit = HKUnit(fromString: "count/min")
        let sampleQuery = HKSampleQuery(sampleType: heartrate!, predicate: nil, limit: 1, sortDescriptors: sort, resultsHandler: { [unowned self] (query, results, error) in
            if let results = results as? [HKQuantitySample]
            {
                let sample = results[0] as HKQuantitySample
                
                let value = sample.quantity.doubleValueForUnit(heartRateUnit)
                print (value)
                let rate = results[0]
                print(results[0])
                print(query)
                self.updateHeartRate(results)
            }
            })
        healthStore?.executeQuery(sampleQuery)
        
    }
    
    func updateHeartRate(samples: [HKSample]?)
    {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {return}
        dispatch_async(dispatch_get_main_queue()) {
            guard let sample = heartRateSamples.first else{return}
            let value = sample.quantity.doubleValueForUnit(self.heartRateUnit!)
            print("Heart Rate: " + String(UInt16(value)))
            let date = sample.startDate
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            print(dateFormatter.stringFromDate(date))
        }
    }
}
