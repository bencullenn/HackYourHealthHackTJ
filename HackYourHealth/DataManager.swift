//
//  DataManager.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import HealthKit

let healthKitStore = HKHealthStore()
let calendar = Calendar.current

private let formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.maximumFractionDigits = 2
    return f
}()

extension Double {
    var formatted: String {
        return formatter.string(from: self as NSNumber) ?? "\(self)"
    }
}

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
    private init() { pull() }

    public var weight: Double?
    public var height: Double?
    public var age: Double?
    public var gender: Gender?
    public var restingHeartRate: Double?
    public var activity: Activity?
    public var calorieIntake: Double?
}

extension DataManager {
    private func fetch(identifier: HKQuantityTypeIdentifier, unit: HKUnit, completion: @escaping (Double?) -> Void) {
        let today = Date()
        let startDate = calendar.date(byAdding: .year, value: -200, to: today)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        guard let type = HKSampleType.quantityType(forIdentifier: identifier) else { return }
        let query = HKSampleQuery(sampleType: type, predicate: predicate, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)])
        { (_, samples, _) in
            completion((samples?.first as? HKQuantitySample)?.quantity.doubleValue(for: unit))
        }
        healthKitStore.execute(query)
    }

    public func pull() {
        if let object = try? healthKitStore.biologicalSex(),
            let gender = Gender.from(hkBiologicalSexObject: object) {
            self.gender = gender
        }

        if let components = try? healthKitStore.dateOfBirthComponents(),
            let birthday = calendar.date(from: components) {
            if let year = calendar.dateComponents([.year], from: birthday, to: Date()).year {
                self.age = Double(year)
            }
        }

        fetch(identifier: .bodyMass, unit: .gramUnit(with: .kilo)) { weight in
            if let weight = weight {
                self.weight = weight
            }
        }
        fetch(identifier: .height, unit: .meterUnit(with: .centi)) { height in
            if let height = height {
                self.height = height
            }
        }
        fetch(identifier: .dietaryEnergyConsumed, unit: .kilocalorie()) { calorie in
            if let calorie = calorie {
                self.calorieIntake = calorie
            }
        }
        fetch(identifier: .heartRate, unit: HKUnit(from: "count/min")) { beats in
            if let beats = beats {
                self.restingHeartRate = beats
            }
        }
    }
    fileprivate func update(_ identifier: HKQuantityTypeIdentifier, to value: Double?, withUnit unit: HKUnit) {
        guard let value = value, let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else { return }
        guard healthKitStore.authorizationStatus(for: quantityType) == .sharingAuthorized else { return }
        fetch(identifier: identifier, unit: unit) { existing in
            if value.formatted != existing?.formatted {
                let quantity = HKQuantity(unit: unit, doubleValue: value)
                let now = Date()
                let sample = HKQuantitySample(type: quantityType, quantity: quantity, start: now, end: now)
                healthKitStore.save(sample) { _,_ in }
            }
        }
    }
    public func push() {
        update(.bodyMass, to: weight, withUnit: .gramUnit(with: .kilo))
        update(.bodyMassIndex, to: BMI, withUnit: .count())
        update(.height, to: height, withUnit: .meterUnit(with: .centi))
        update(.dietaryEnergyConsumed, to: calorieIntake, withUnit: .kilocalorie())
    }
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
