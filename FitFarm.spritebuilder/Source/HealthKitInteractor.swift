//
//  ProfileViewController.swift
//  HealthKit~Swift
//
//  Created by EdenLi on 2014/9/17.
//  Copyright (c) 2014年 Darktt Personal Company. All rights reserved.
//

import UIKit
import HealthKit

enum ProfileViewControllerTableViewIndex : Int {
    case Age = 0
    case Height
    case Weight
}

enum ProfileKeys : String {
    case Age = "age"
    case Height = "height"
    case Weight = "weight"
}

class ProfileViewController: UITableViewController
{
    
    private let kProfileUnit = 0
    private let kProfileDetail = 1
    
    var healthStore: HKHealthStore?
    
    private var userProfiles: [ProfileKeys: [String]]?
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Set up an HKHealthStore, asking the user for read/write permissions. The profile view controller is the
        // first view controller that's shown to the user, so we'll ask for all of the desired HealthKit permissions now.
        // In your own app, you should consider requesting permissions the first time a user wants to interact with
        // HealthKit data.
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
        
        let writeDataTypes: Set<HKSampleType> = self.dataTypesToWrite()
        let readDataTypes: Set<HKObjectType> = self.dataTypesToRead()
        
        let completion: ((Bool, NSError?) -> Void)! = {
            (success, error) -> Void in
            
            if !success {
                print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error). If you're using a simulator, try it on a device.")
                
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                () -> Void in
                
                // Update the user interface based on the current user's health information.
                self.updateUserAge()
            })
        }
        
        self.healthStore?.requestAuthorizationToShareTypes(writeDataTypes, readTypes: readDataTypes, completion: completion)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Your Profile"
        
        self.userProfiles = [ProfileKeys.Age: [NSLocalizedString("Age (yrs)", comment: ""), NSLocalizedString("Not available", comment: "")],
            ProfileKeys.Height: [NSLocalizedString("Height ()", comment: ""), NSLocalizedString("Not available", comment: "")],
            ProfileKeys.Weight: [NSLocalizedString("Weight ()", comment: ""), NSLocalizedString("Not available", comment: "")]]
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Method
    //MARK: HealthKit Permissions
    
    private func dataTypesToWrite() -> Set<HKSampleType>
    {
        let dietaryCalorieEnergyType: HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!
        let activeEnergyBurnType: HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!
        let heightType:  HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        let weightType: HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
        
        let writeDataTypes: Set<HKSampleType> = [dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType]
        
        return writeDataTypes
    }
    
    private func dataTypesToRead() -> Set<HKObjectType>
    {
        let dietaryCalorieEnergyType: HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)!
        let activeEnergyBurnType: HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)!
        let heightType:  HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        let weightType: HKQuantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!
        let birthdayType: HKCharacteristicType = HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!
        let biologicalSexType: HKCharacteristicType = HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)!
        
        let readDataTypes: Set<HKObjectType> = [dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, birthdayType, biologicalSexType]
        
        return readDataTypes
    }
    
    //MARK: - Reading HealthKit Data
    
    private func updateUserAge() -> Void
    {
        let dateOfBirth: NSDate?
        
        do {
            
            dateOfBirth = try self.healthStore?.dateOfBirth()
            
        } catch _ as NSError {
            
            dateOfBirth = nil
            
        }
        
        if dateOfBirth == nil {
            print("Either an error occured fetching the user's age information or none has been stored yet. In your app, try to handle this gracefully.")
            
            return
        }
        
        let now: NSDate = NSDate()
        
        let ageComponents: NSDateComponents = NSCalendar.currentCalendar().components(.Year, fromDate: dateOfBirth!, toDate: now, options: .WrapComponents)
        
        let userAge: Int = ageComponents.year
        
        let ageValue: String = NSNumberFormatter.localizedStringFromNumber(userAge, numberStyle: NSNumberFormatterStyle.NoStyle)
        
        if var userProfiles = self.userProfiles {
            var age: [String] = userProfiles[ProfileKeys.Age] as [String]!
            age[kProfileDetail] = ageValue
            
            userProfiles[ProfileKeys.Age] = age
            self.userProfiles = userProfiles
        }
        
        // Reload table view (only age row)
        let indexPath: NSIndexPath = NSIndexPath(forRow: ProfileViewControllerTableViewIndex.Age.rawValue, inSection: 0)
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    //MARK: - UITableView DataSource Methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let CellIdentifier: String = "CellIdentifier"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: CellIdentifier)
        }
        
        var profilekey: ProfileKeys?
        
        switch indexPath.row {
        case 0:
            profilekey = .Age
            
        case 1:
            profilekey = .Height
            
        case 2:
            profilekey = .Weight
            
        default:
            break
        }
        
        if let profiles = self.userProfiles {
            let profile: [String] = profiles[profilekey!] as [String]!
            
            cell!.textLabel!.text = profile.first as String!
            cell!.detailTextLabel!.text = profile.last as String!
        }
        
        return cell!
    }
    
    //MARK: - UITableView Delegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let index: ProfileViewControllerTableViewIndex = ProfileViewControllerTableViewIndex(rawValue: indexPath.row)!
        
        // We won't allow people to change their date of birth, so ignore selection of the age cell.
        if index == .Age {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            return
        }
        
        // Set up variables based on what row the user has selected.
        var title: String?
        var valueChangedHandler: (Double -> Void)?
        
        if index == .Height {
            title = NSLocalizedString("Your Height", comment: "")
        }
        
        if index == .Weight {
            title = NSLocalizedString("Your Weight", comment: "")
        }
        
        // Create an alert controller to present.
        let alertController: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        // Add the text field to let the user enter a numeric value.
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // Only allow the user to enter a valid number.
            textField.keyboardType = UIKeyboardType.DecimalPad
        }
        
        // Create the "OK" button.
        let okTitle: String = NSLocalizedString("OK", comment: "")
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            let textField: UITextField = alertController.textFields!.first!
            
            let text: NSString = textField.text!
            let value: Double = text.doubleValue
            
            valueChangedHandler!(value)
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        alertController.addAction(okAction)
        
        // Create the "Cancel" button.
        let cancelTitle: String = NSLocalizedString("Cancel", comment: "")
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.Cancel) { (action) -> Void in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        alertController.addAction(cancelAction)
        
        // Present the alert controller.
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}