//
//  Extensions.swift
//  Sport
//
//  Created by Amir on 4/11/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import Foundation

extension Double{
    
    func metersToMiles(places: Int = 2) -> Double{
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}

extension Int{
    
    func formatTimeDurationToString() -> String{
        
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = (self % 3600) % 60
        
        if durationSeconds < 0{
            return "00:00:00"
        }else if durationHours == 0{
            return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durationSeconds)
        }else{
            return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durationSeconds)
        }
    }
}