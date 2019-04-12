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


extension NSDate{
    
    func getDateString() -> String {
        let calendare = Calendar.current
        let second = calendare.component(.second, from: self as Date)
        let minute = calendare.component(.minute, from: self as Date)
        let hour = calendare.component(.hour, from: self as Date)
        let month = calendare.component(.month, from: self as Date)
        let day = calendare.component(.day, from: self as Date)
        let year = calendare.component(.year, from: self as Date)
        
        return "\(day)/\(month)/\(year) - \(hour):\(minute):\(second)"
    }
}
