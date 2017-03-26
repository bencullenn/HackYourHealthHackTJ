//
//  DataManager.swift
//  HackYourHealth
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import Foundation

public enum Gender: Int {
    case male
    case female
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
    private init()
    {
        
    }
    
    public var weight: Double?
    public var height: Double?
    public var age: Double?
    public var gender: Gender?
    public var restingHeartRate : Double?
    public var activity: Activity?
    public var calorieIntake: Double?
    public var BMR: Double?
    public var MHR: Double?
    public var MAC: Double?
    public var TDEE: Double?
}
