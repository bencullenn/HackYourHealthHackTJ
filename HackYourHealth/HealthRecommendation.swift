//
//  HealthRecommendation.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import Foundation

public struct HealthRecommendation {
    public let title: String
    public let healthyValue: Double
    public let summary: String
    public let higherValueIsUnhealthy: Bool

    ///decides whether to recommend a health improvment
    func shouldRecommendHealthImprovement(currentHealthValue: Double) -> Bool {
        return higherValueIsUnhealthy
            ? healthyValue <= currentHealthValue
            : healthyValue >= currentHealthValue
    }
}

extension HealthRecommendation {
    static func recommended(for currentHealthValue: Double) -> [HealthRecommendation] {
        return HealthRecommendation.all.filter { (recommendation) -> Bool in
            return recommendation.shouldRecommendHealthImprovement(currentHealthValue: currentHealthValue)
        }
    }
    static let all: [HealthRecommendation] = [.lowRestingHeartRate,.highRestingHeartRate,.lowActivityFactor,.lowCaloricIntake,.highCaloricIntake,.lowBMI,.highBMI]
    
    static let lowRestingHeartRate = HealthRecommendation (title:"Extremly Low Resting Heart Rate", healthyValue: 50, summary:"Your resting heart rate is less than 50 BPM. This is unnaturually low and it is recommended that you seek a docotor", higherValueIsUnhealthy: false)
    
    static let highRestingHeartRate = HealthRecommendation(title: "Higher than usual resting heart rate", healthyValue: 72, summary: "You have a resting heart rate that is higher than usual. This is usually caused by lack of aerobic exercises. It is recommended that you particiate in acitives that exercise your arobic system such as Walking, Jogging, or Biking", higherValueIsUnhealthy: true)
    
    static let lowActivityFactor = HealthRecommendation(title: "Low Activity Factor", healthyValue: 1.55, summary: "Your health can be incrased by paricipating in excersie more often", higherValueIsUnhealthy: false)
  
    static let lowCaloricIntake =  HealthRecommendation(title: "Low Caloric Intake", healthyValue: DataManager.shared.TDEE!, summary: "You don't seem to be intaking enough calories. We recommend eating more food", higherValueIsUnhealthy: false)
   
    static let highCaloricIntake =  HealthRecommendation(title: "High Caloric Intake", healthyValue: DataManager.shared.TDEE!*1.5, summary: "You are cosuming more calories than you burn on a daily basis. Comsuming less food is recommended to improve your health", higherValueIsUnhealthy: true)

    static let lowBMI =  HealthRecommendation(title: "Low BMI", healthyValue: 18.5, summary: "You have a low body mass index. It is recommended that you add 200 calories to your diet to increase it to a healthy level", higherValueIsUnhealthy: false)
    
    static let highBMI =  HealthRecommendation(title: "High BMI", healthyValue: 24.9, summary: "You have a higher body mass index that is recommended for your height. Weight loss is suggested to optimize your health. ", higherValueIsUnhealthy: true)
    
    

}
