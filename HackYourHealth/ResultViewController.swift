//
//  ResultViewController.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var bmr: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    print ("It ran")
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
        
        print ("It finished")
        self.bmr.text = String(result);
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
