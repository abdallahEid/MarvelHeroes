//
//  DataResponse.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

struct DataResponse : Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: Data
    
}
