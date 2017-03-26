//
//  HealthRecommendation.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import Foundation

public class HealthRecommendation
{
    public var healthyValue:Double?
    public var advice:String?
    public var higherValueIsUnhealthy:Bool?
    
    private init(healthyValue:Double,advice:String,higherValueIsUnhealthy:Bool)
    {
      self.healthyValue = healthyValue
      self.advice = advice
      self.higherValueIsUnhealthy = higherValueIsUnhealthy
    
    }
    
    func shouldRecommendHealthImprovement (currentHealthValue:Double) ->  Bool  //decides whether to recommend a health improvment
    {
        if (higherValueIsUnhealthy)!
        {
            if (healthyValue! > currentHealthValue)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
           if (healthyValue! < currentHealthValue)
           {
             return false
           }
           else
           {
             return true
           }
        }
    }
    
}
