//
//  UserDefaults+keys.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 20.06.21.
//

import Foundation

extension UserDefaults {
    
    func setValue(_ value: Any?, forKey key: UserDefaultKeys) {
        self.setValue(value, forKey: key.rawValue)
    }
}
