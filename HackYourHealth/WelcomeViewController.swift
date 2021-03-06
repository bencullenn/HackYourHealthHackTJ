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

    @IBAction func requestHealthPermissions(_ sender: Any) {
        let identifiers: [HKQuantityTypeIdentifier] = [
            .bodyMassIndex, .height, .bodyMass, .heartRate, .dietaryEnergyConsumed
        ]
        // State the health data types we want to read from HealthKit.
        var healthDataToRead = Set<HKObjectType>(identifiers.map { (id) in
            HKObjectType.quantityType(forIdentifier: id)!
        })
        healthDataToRead.insert(HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!)

        // State the health data types we want to write from HealthKit.
        let healthDataToWrite = Set<HKQuantityType>(identifiers.compactMap { (id) in
            if id == .heartRate { return nil }
            return HKObjectType.quantityType(forIdentifier: id)
        })

        // Just in case our app makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable() {
            print("Can't access HealthKit.")
        }

        // Request authorization to read and/or write the specific data.
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead)
        { (success, error) in
            if !success {
                print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error!). If you're using a simulator, try it on a device.")
            } else {
                DataManager.shared.pull()
            }
            DispatchQueue.main.sync { [weak self] in
                self?.performSegue(withIdentifier: "showBasicInfoView", sender: nil)
            }
        }
    }
}
