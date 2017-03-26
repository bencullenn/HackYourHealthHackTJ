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
        var result = 0.0;
        
        if DataManager.shared.gender == .female {
            let part1 = 655 + 9.6*DataManager.shared.weight!
            let part2 = 1.8*DataManager.shared.height!
            let part3 = 4.7*DataManager.shared.age!
            result = Double(part1 + part2 - part3);
        }
        if DataManager.shared.gender == .male {
            let part1 = 66 + 13.7*DataManager.shared.weight!
            let part2 = 5*DataManager.shared.height!
            let part3 = 6.8*DataManager.shared.age!
            
            print("Part1:\(part1)) \n Part2:\(part2) \n Part3:\(part3)")
            result = Double(part1 + part2 - part3);
            print ("Result\(result)")
        }

        self.bmr.text = String(result);
        DataManager.shared.BMR = result;
        
        let maxHeartRateResult = Double(208 - 0.7*DataManager.shared.age!);
        self.maxHeartRate.text = String(maxHeartRateResult);
        DataManager.shared.MHR = maxHeartRateResult;
        
        let vo2MaxResult = 15.3*maxHeartRateResult/DataManager.shared.restingHeartRate!;
        self.vo2Max.text = String(vo2MaxResult);
        DataManager.shared.MAC = vo2MaxResult;
        
        let TDEEresult = result*DataManager.shared.activity!.value
    
        self.tdee.text = String(TDEEresult);
        DataManager.shared.TDEE = TDEEresult;
        
        let BMIresult = DataManager.shared.weight!/(DataManager.shared.height!*100*DataManager.shared.height!*100)
        self.bmi.text = String(BMIresult);
        DataManager.shared.BMI = BMIresult;
        // Do any additional setup a

    }

}
