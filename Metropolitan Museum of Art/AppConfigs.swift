//
//  AppConfigs.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation


class AppConfigs {
    
    static var shared = AppConfigs()
    
    let baseURL = "https://collectionapi.metmuseum.org"
    
    private init() {
        print("App Configs created")
    }
}
