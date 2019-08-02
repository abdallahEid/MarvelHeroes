//
//  MarvelResponse.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

struct MarvelResponse <DataResponse: Codable> : Codable {
    let code: Int
    let status: String
    let data: DataResponse
    
    
}
