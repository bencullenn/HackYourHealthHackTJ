//
//  ResultViewController.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var bmi: UILabel!
    @IBOutlet var vo2Max: UILabel!
    @IBOutlet var bmr: UILabel!
    @IBOutlet var tdee: UILabel!
    @IBOutlet var maxHeartRate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let bmr = DataManager.shared.BMR {
            self.bmr.text = "\(bmr)"
        }

        if let maxHeartRateResult = DataManager.shared.MHR {
            self.maxHeartRate.text = "\(maxHeartRateResult)"
        }

        if let vo2MaxResult = DataManager.shared.MAC {
            self.vo2Max.text = "\(vo2MaxResult)"
        }

        if let tdeeResult = DataManager.shared.TDEE {
            self.tdee.text = "\(tdeeResult)"
        }

        if let bmiResult = DataManager.shared.BMI {
            self.bmi.text = "\(bmiResult)"
        }
    }
    
}
