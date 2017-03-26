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
        return HealthRecommendation.all.filter {
            $0.shouldRecommendHealthImprovement(currentHealthValue: currentHealthValue)
        }
    }
    static let all: [HealthRecommendation] = [.fake]
    static let fake = HealthRecommendation(title: "Fake Recommendation", healthyValue: 0, summary: "Lorem Ipsum", higherValueIsUnhealthy: true)

}
