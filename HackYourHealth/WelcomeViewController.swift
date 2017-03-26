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
        guard HKHealthStore.isHealthDataAvailable() else {return}
        
        let healthStore = HKHealthStore ()
        //let sharableTypes = Set([])
        //let readableTypes = Set([])
        //healthStore.requestAuthorization(toShare: sharableTypes, read: readableTypes) completion success,error in {
        
       // }
    }

    
}
