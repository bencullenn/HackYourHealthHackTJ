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

public enum Activity: Double {
    case s = 1.2
    case l = 1.375
    case m = 1.55
    case v = 1.725
    case e = 1.9
}

public class DataManager {
    public static let shared = DataManager()
    private init(){}
    
    public var weight: Double?
    public var height: Double?
    public var age: Double?
    public var gender: Gender?
    public var restingHeartRate : Double?
    public var activity: Double?
    public var calorieIntake: Double?
}
