//
//  DataManager.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import Foundation
import HealthKit

public enum Gender: Int {
    case male
    case female

    static func from(hkBiologicalSexObject object: HKBiologicalSexObject) -> Gender? {
        switch object.biologicalSex {
        case .male: return .male
        case .female: return .female
        default: return nil
        }
    }
}

public enum Activity: Int {
    case s, l, m, v, e
    var value: Double {
        switch self {
        case .s: return 1.200
        case .l: return 1.375
        case .m: return  1.550
        case .v: return  1.725
        case .e: return  1.900
        }
    }
}

public class DataManager {
    public static let shared = DataManager()
    private init(){}

    public var weight: Double?
    public var height: Double?
    public var age: Double?
    public var gender: Gender?
    public var restingHeartRate : Double?
    public var activity: Activity?
    public var calorieIntake: Double?
}

extension DataManager {
    public var BMR: Double? {
        guard let gender = gender,
            let weight = weight,
            let height = height,
            let age = age
            else { return nil }

        switch gender {
        case .male:
            let part1 = 655 + 9.6 * weight
            let part2 = 1.8 * height
            let part3 = 4.7 * age
            return part1 + part2 - part3
        case .female:
            let part1 = 66 + 13.7 * weight
            let part2 = 5 * height
            let part3 = 6.8 * age
            return part1 + part2 - part3
        }
    }

    public var MHR: Double? {
        if let age = age {
            return 208 - 0.7 * age
        } else {
            return nil
        }
    }

    public var MAC: Double? {
        if let maxHeartRateResult = MHR, let restingHeartRate = restingHeartRate {
            return 15.3 * maxHeartRateResult / restingHeartRate
        } else {
            return nil
        }
    }

    public var TDEE: Double? {
        if let bmr = BMR, let activity = activity {
            return bmr * activity.value
        } else {
            return nil
        }
    }

    public var BMI: Double? {
        if let weight = weight, let height = height {
            return weight/pow(height/100, 2)
        } else {
            return nil
        }
    }
}
