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
    public let healthyValue:Double
    public let title:String
    public let summary:String
    public let higherValueIsUnhealthy:Bool
    
    private init(title:String,healthyValue:Double,summary:String,higherValueIsUnhealthy:Bool)
    {
        self.title = title
        self.healthyValue = healthyValue
        self.summary = summary
        self.higherValueIsUnhealthy = higherValueIsUnhealthy
    }
    
    func shouldRecommendHealthImprovement (currentHealthValue:Double) ->  Bool  //decides whether to recommend a health improvment
    {
        if (higherValueIsUnhealthy)
        {
            if (healthyValue > currentHealthValue)
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
           if (healthyValue < currentHealthValue)
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
