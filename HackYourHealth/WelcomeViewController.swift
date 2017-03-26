//
//  WelcomeViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit
import HealthKit

class WelcomeViewController: UIViewController {
    let healthKitStore: HKHealthStore = HKHealthStore()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:Functions
    @IBAction func requestHealthPermissions(_ sender: Any)
    {
        authorizeHealthKit()
    }

    func authorizeHealthKit() {

        // State the health data type(s) we want to read from HealthKit.
        let healthDataToRead = Set(arrayLiteral:HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)
        // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)

        // Just in case OneHourWalker makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable()
        {
            print("Can't access HealthKit.")
        }

        // Request authorization to read and/or write the specific data.
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead)
        { (success, error) in
            if !success {
                print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error). If you're using a simulator, try it on a device.")
            }
        }
        performSegue(withIdentifier: "showBasicInfoView", sender: nil)
    }
}
