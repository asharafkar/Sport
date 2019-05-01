//
//  Location.swift
//  Sport
//
//  Created by Amir on 5/1/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object{
    
    dynamic public private(set) var latitude: Double = 0.0
    dynamic public private(set) var longitude: Double = 0.0
    
    convenience init(latitude: Double, longitude: Double){
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
