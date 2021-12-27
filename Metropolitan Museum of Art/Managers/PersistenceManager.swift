//
//  PersistenceManager.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation

class PersistenceManager {
    
    let defaults = UserDefaults.standard
    private var valueList: [String]
    private var key: String
    
    init(forKey: String = "favoriteList") {
        valueList = []
        key = forKey
        fetchList()
    }
    
    private func fetchList() {
        
        guard let list = defaults.stringArray(forKey: key) else {
            return
        }
        valueList = list
    }
    
    public func getDefaults() -> [String] {
        
        return self.valueList
    }
    
    public func addToDefaults(value: String) {
        
        var list = getDefaults()
        list.append(value)
        defaults.setValue(list, forKey: key)
    }
    
    public func isInDefaultsList(value: String) -> Bool {
        
        return valueList.contains(value)
    }
    
    public func getListAfterDeleting(value: String) -> [String] {

        if let index = valueList.firstIndex(of: value) {
            valueList.remove(at: index)
        }
    
        defaults.setValue(valueList, forKey: key)
        
        return valueList
    }
    
}
