//
//  ExtraInfoViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class ExtraInfoViewController: UIViewController {
    @IBOutlet var restingHeartRateField: UITextField!
    @IBOutlet var activitySelector: UITextField!
    @IBOutlet var calorieIntakeField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        DataManager.shared.restingHeartRate = Double(restingHeartRateField.text!)
        
        DataManager.shared.calorieIntake = Double(calorieIntakeField.text!)
        //if segue.identifier == ResultViewController, let vc = //segue.destination as ResultViewController {
        

        //}
    }
    
    
}

