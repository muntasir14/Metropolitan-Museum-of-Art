//
//  SearchResponseModel.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation

struct SearchResponseModel: Decodable {
    let total: Int
    let objectIDs: [Int]
}
