//
//  DataResponse.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

struct DataResponse< Results: Codable > : Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Results]
    
}

struct Results<T: Codable> : Codable {
    
}
