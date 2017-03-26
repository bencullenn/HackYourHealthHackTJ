//
//  ResultViewController.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var vo2Max: UILabel!
    @IBOutlet var bmr: UILabel!
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
            result = Double(part1 + part2 - part3);
        }
        self.bmr.text = String(result);
        
        var maxHeartRateResult = Double(208 - 0.7*DataManager.shared.age!);
        self.maxHeartRate.text = String(maxHeartRateResult);
        
        var vo2MaxResult = 15.3*maxHeartRateResult/DataManager.shared.restingHeartRate!;
        self.vo2Max.text = String(vo2MaxResult);
        // Do any additional setup a
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
