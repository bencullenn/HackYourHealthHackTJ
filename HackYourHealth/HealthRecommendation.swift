//
//  HealthRecommendation.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

public struct HealthRecommendation {
    public let title: String
    public let healthyValue: Double
    public let summary: String
    public let higherValueIsUnhealthy: Bool
    public let currentValue: () -> Double?

    /// Decides whether to recommend a health improvment.
    func shouldRecommendHealthImprovement(for currentHealthValue: Double) -> Bool {
        return higherValueIsUnhealthy
            ? healthyValue <= currentHealthValue
            : healthyValue >= currentHealthValue
    }
}

extension HealthRecommendation: CaseIterable {
    static func recommended() -> [HealthRecommendation] {
        return HealthRecommendation.allCases.filter { (recommendation) in
            guard let value = recommendation.currentValue()
                else { return false }
            return recommendation.shouldRecommendHealthImprovement(for: value)
        }
    }

    public static let allCases: [HealthRecommendation] = [.lowRestingHeartRate,.highRestingHeartRate,.lowActivityFactor,.lowCaloricIntake,.highCaloricIntake,.lowBMI,.highBMI]

    static let lowRestingHeartRate = HealthRecommendation (title:"Extremly Low Resting Heart Rate", healthyValue: 50, summary:"Your resting heart rate is less than 50 BPM. This is unnaturually low and it is recommended that you seek a docotor", higherValueIsUnhealthy: false) { DataManager.shared.restingHeartRate }

    static let highRestingHeartRate = HealthRecommendation(title: "Higher than usual resting heart rate", healthyValue: 72, summary: "You have a resting heart rate that is higher than usual. This is usually caused by lack of aerobic exercises. It is recommended that you particiate in acitives that exercise your arobic system such as Walking, Jogging, or Biking", higherValueIsUnhealthy: true) { DataManager.shared.restingHeartRate }

    static let lowActivityFactor = HealthRecommendation(title: "Low Activity Factor", healthyValue: 1.55, summary: "Your health can be incrased by paricipating in excersie more often", higherValueIsUnhealthy: false) { DataManager.shared.activity?.value }

    static let lowCaloricIntake =  HealthRecommendation(title: "Low Caloric Intake", healthyValue: DataManager.shared.TDEE!, summary: "You don't seem to be intaking enough calories. We recommend eating more food", higherValueIsUnhealthy: false) { DataManager.shared.calorieIntake }

    static let highCaloricIntake =  HealthRecommendation(title: "High Caloric Intake", healthyValue: DataManager.shared.TDEE!*1.5, summary: "You are cosuming more calories than you burn on a daily basis. Comsuming less food is recommended to improve your health", higherValueIsUnhealthy: true) { DataManager.shared.calorieIntake }

    static let lowBMI =  HealthRecommendation(title: "Low BMI", healthyValue: 18.5, summary: "You have a low body mass index. It is recommended that you add 200 calories to your diet to increase it to a healthy level", higherValueIsUnhealthy: false) { DataManager.shared.BMI }

    static let highBMI =  HealthRecommendation(title: "High BMI", healthyValue: 24.9, summary: "You have a higher body mass index that is recommended for your height. Weight loss is suggested to optimize your health. ", higherValueIsUnhealthy: true) { DataManager.shared.BMI }
}
