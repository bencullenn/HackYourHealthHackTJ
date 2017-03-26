//
//  DataManager.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import Foundation
import HealthKit

let healthKitStore = HKHealthStore()
let calendar = Calendar.current

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
    static let healthKitIdentifiers: [HKQuantityTypeIdentifier] = [.bodyMass, .height, .bodyMassIndex, .heartRate, .dietaryEnergyConsumed]

    private func fetch(identifier: HKQuantityTypeIdentifier, unit: HKUnit, completion: @escaping (Double) -> Void) {
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        if let startDate = calendar.date(from: components) {
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
            if let sampleType = HKSampleType.quantityType(forIdentifier: identifier) {
                if healthKitStore.authorizationStatus(for: sampleType) == .sharingAuthorized {
                    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
                    let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (_, samples, _) in
                        if let sample = samples?.first as? HKQuantitySample {
                            completion(sample.quantity.doubleValue(for: unit))
                        }
                    }
                    healthKitStore.execute(query)
                }
            }
        }
    }

    public func pull() {
        if let object = try? healthKitStore.biologicalSex(), let gender = Gender.from(hkBiologicalSexObject: object) {
            self.gender = gender
        }

        let now = Date()
        if let components = try? healthKitStore.dateOfBirthComponents(),
            let birthday = calendar.date(from: components) {
            if let year = calendar.dateComponents([.year], from: birthday, to: now).year {
                self.age = Double(year)
            }
        }

        fetch(identifier: .bodyMass, unit: HKUnit.gramUnit(with: .kilo)) { weight in
            self.weight = weight
        }
        fetch(identifier: .height, unit: HKUnit.meterUnit(with: .centi)) { height in
            self.height = height
        }
        fetch(identifier: .dietaryEnergyConsumed, unit: HKUnit.kilocalorie()) { calorie in
            self.calorieIntake = calorie
        }
        fetch(identifier: .heartRate, unit: HKUnit.count()) { beats in
            self.restingHeartRate = beats
        }
    }
    public func store(value: Double?, identifier: HKQuantityTypeIdentifier, unit: HKUnit) {
        guard let value = value, let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else { return }
        let quantity = HKQuantity(unit: unit, doubleValue: value)
        let now = Date()
        let sample = HKQuantitySample(type: quantityType, quantity: quantity, start: now, end: now)
        healthKitStore.save(sample) {_,_ in}
    }
    public func push() {
        store(value: weight, identifier: .bodyMass, unit: HKUnit.gramUnit(with: .kilo))
        store(value: BMI, identifier: .bodyMassIndex, unit: HKUnit.count())
        store(value: height, identifier: .height, unit: HKUnit.meterUnit(with: .centi))
        store(value: calorieIntake, identifier: .dietaryEnergyConsumed, unit: HKUnit.kilocalorie())
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
