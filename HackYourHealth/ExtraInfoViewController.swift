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
    @IBOutlet var activitySelector: UISegmentedControl!
    @IBOutlet var calorieIntakeField: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let restingHeartRate = DataManager.shared.restingHeartRate {
            restingHeartRateField.text = "\(restingHeartRate)"
        }
        if let calorieIntake = DataManager.shared.calorieIntake {
            calorieIntakeField.text = "\(calorieIntake)"
        }
        if let activity = DataManager.shared.activity {
            activitySelector.selectedSegmentIndex = activity.rawValue
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DataManager.shared.restingHeartRate = Double(restingHeartRateField.text!)
        DataManager.shared.calorieIntake = Double(calorieIntakeField.text!)
        DataManager.shared.activity = Activity(rawValue: activitySelector.selectedSegmentIndex)
    }
}
