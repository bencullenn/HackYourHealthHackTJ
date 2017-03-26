//
//  RecommendationsTableViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class RecommendationsTableViewController: UITableViewController {
    
    static let lowRestingHeartRate = HealthRecommendation (title:"Extremely Low Resting Heart Rate", healthyValue: 50, summary:"Your resting heart rate is less than 50 BPM. This is unnaturally low and it is recommended that you seek a docotor", higherValueIsUnhealthy: false)
    
    static let highRestingHeartRate = HealthRecommendation(title: "Higher than usual resting heart rate", healthyValue: 72, summary: "You have a resting heart rate that is higher than usual. This is usually caused by lack of aerobic exercises. It is recommended that you particiate in acitives that exercise your aerobic system such as Walking, Jogging, or Biking", higherValueIsUnhealthy: true)
    
    static let lowActivityFactor = HealthRecommendation(title: "Low Activity Factor", healthyValue: 1.55, summary: "Your health can be increased by paricipating in exercise more often", higherValueIsUnhealthy: false)
    
    static let lowCaloricIntake =  HealthRecommendation(title: "Low Caloric Intake", healthyValue: DataManager.shared.TDEE!, summary: "You don't seem to be intaking enough calories. We recommend eating more food", higherValueIsUnhealthy: false)
    
    static let highCaloricIntake =  HealthRecommendation(title: "High Caloric Intake", healthyValue: DataManager.shared.TDEE!*1.5, summary: "You are consuming more calories than you burn on a daily basis. Consuming less food is recommended to improve your health", higherValueIsUnhealthy: true)
    
    static let lowBMI =  HealthRecommendation(title: "Low BMI", healthyValue: 18.5, summary: "You have a low body mass index. It is recommended that you add 200 calories to your diet to increase it to a healthy level", higherValueIsUnhealthy: false)
    
    static let highBMI =  HealthRecommendation(title: "High BMI", healthyValue: 24.9, summary: "You have a higher body mass index than is recommended for your height. Weight loss is suggested to optimize your health. ", higherValueIsUnhealthy: true)

    
    /*var current: Double = 0
=======
     var recommendations = [HealthRecommendation] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let lowRestingHeartRate = HealthRecommendation (title:"Extremly Low Resting Heart Rate", healthyValue: 50, summary:"Your resting heart rate is less than 50 BPM. This is unnaturually low and it is recommended that you seek a docotor", higherValueIsUnhealthy: false)
        
        if lowRestingHeartRate.shouldRecommendHealthImprovement(currentHealthValue: DataManager.shared.restingHeartRate!)
        {
            recommendations.append(lowRestingHeartRate)
        }
        
        let highRestingHeartRate = HealthRecommendation(title: "Higher than usual resting heart rate", healthyValue: 72, summary: "You have a resting heart rate that is higher than usual. This is usually caused by lack of aerobic exercises. It is recommended that you particiate in acitives that exercise your arobic system such as Walking, Jogging, or Biking", higherValueIsUnhealthy: true)
        
        if highRestingHeartRate.shouldRecommendHealthImprovement(currentHealthValue: DataManager.shared.restingHeartRate!)
>>>>>>> origin/Recommendations
        {
            recommendations.append(highRestingHeartRate)
        }
        
        let lowActivityFactor = HealthRecommendation(title: "Low Activity Factor", healthyValue: 1.55, summary: "Your health can be incrased by paricipating in exercise more often", higherValueIsUnhealthy: false)
        
        if lowActivityFactor.shouldRecommendHealthImprovement(currentHealthValue: Double(DataManager.shared.activity!.rawValue))
        {
            recommendations.append(lowActivityFactor)
        }
    }*/
    private var potentialRecommendations: [HealthRecommendation] = [lowBMI,highBMI,highCaloricIntake,lowCaloricIntake,lowActivityFactor,highRestingHeartRate,lowRestingHeartRate]
    
    private var recommendations: [HealthRecommendation] = []
    override func viewDidLoad() {


    
    //for (HealthRecommendation recommendation :potentialRecommendations)
    //{
            //find out the right recommendation value for the recommendation EX:Heart rate for lowRestingHeartRate
    
            //if (recommendation.shouldRecommendHealthImprovement())
            //{
                //display to TableViewController
    
            //Test recommendation values
    
            //}
    
        let lowCaloricIntake =  HealthRecommendation(title: "Low Caloric Intake", healthyValue: DataManager.shared.TDEE!, summary: "You don't seem to be intaking enough calories. We recommend eating more food", higherValueIsUnhealthy: false)
        
        if lowCaloricIntake.shouldRecommendHealthImprovement(currentHealthValue: DataManager.shared.calorieIntake!)
        {
            recommendations.append(lowCaloricIntake)
        }
        
        let highCaloricIntake =  HealthRecommendation(title: "High Caloric Intake", healthyValue: DataManager.shared.TDEE!*1.5, summary: "You are cosuming more calories than you burn on a daily basis. Comsuming less food is recommended to improve your health", higherValueIsUnhealthy: true)
        
        if highCaloricIntake.shouldRecommendHealthImprovement(currentHealthValue: DataManager.shared.calorieIntake!)
        {
            recommendations.append(highCaloricIntake)
        }
        
        let lowBMI =  HealthRecommendation(title: "Low BMI", healthyValue: 18.5, summary: "You have a low body mass index. It is recommended that you add 200 calories to your diet to increase it to a healthy level", higherValueIsUnhealthy: false)
        
        if lowBMI.shouldRecommendHealthImprovement(currentHealthValue: DataManager.shared.BMI!)
        {
            recommendations.append(lowBMI)
        }
        
        let highBMI =  HealthRecommendation(title: "High BMI", healthyValue: 24.9, summary: "You have a higher body mass index that is recommended for your height. Weight loss is suggested to optimize your health. ", higherValueIsUnhealthy: true)
        
        if highBMI.shouldRecommendHealthImprovement(currentHealthValue: DataManager.shared.BMI!)
        {
            recommendations.append(highBMI)
        }
        
   // }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    

    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")

        cell.textLabel?.text = "\(recommendations[indexPath.row])"
        cell.textLabel?.text = "\(recommendations[indexPath.row].title)"

        return cell
    }

    
    
}
