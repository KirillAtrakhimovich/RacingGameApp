//
//  UserSettings.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 20.06.21.
//

import Foundation

class UserSettings: Codable {
    var name: String
    var car: CarsType
    var barrier : BarriersType
    
    internal init(name: String, car: CarsType, barrier: BarriersType) {
        self.name = name
        self.car = car
        self.barrier = barrier
    }
    
    
}
