//
//  ViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/25/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class BasicInfoViewController:UIViewController {

    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var heightLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var sexSelection: UISegmentedControl!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExtraInfoViewController" {
            if let age = ageLabel.text {
                DataManager.shared.age = Double(age)
            }
            if let weight = weightLabel.text {
                DataManager.shared.weight = Double(weight)
            }
            if let height = heightLabel.text {
                DataManager.shared.height = Double(height)
            }
            DataManager.shared.gender = Gender(rawValue: sexSelection.selectedSegmentIndex)
        }
    }

}

