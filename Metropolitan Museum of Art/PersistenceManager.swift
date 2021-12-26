//
//  PersistenceManager.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation

class PersistenceManager {
    
    let defaults = UserDefaults.standard
    
    public func getDefaults(forKey: String) -> [String] {
        
        guard let list = defaults.stringArray(forKey: forKey) else {
            return []
        }
        return list
    }
    
    public func addToDefaults(value: String, forKey: String) {
        
        var list = getDefaults(forKey: forKey)
        list.append(value)
        defaults.setValue(list, forKey: forKey)
    }
    
}
