//
//  ViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/25/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class BasicInfoViewController:UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var sexSelection: UISegmentedControl!

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier == "showExtraInfoViewController" {
        switch sexSelection.selectedSegmentIndex
        {
            case 0:
                DataManager.shared.gender = "Male";
            case 1:
                DataManager.shared.gender = "Female";
            default:
                DataManager.shared.gender = "Male";
        }
        }
        }
}

