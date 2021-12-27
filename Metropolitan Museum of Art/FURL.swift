//
//  FURL.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation


class FURL {
    
    private static let searchURL = "/public/collection/v1/search?"
    private static let objectURL = "/public/collection/v1/objects/"
    
    static func getSearchURL(for key: String) -> String {
        
        return AppConfigs.shared.baseURL + searchURL + "q=\(key)"
    }
    
    static func getObjectURL(for id: String) -> String {
        
        return AppConfigs.shared.baseURL + objectURL + id
    }
}
