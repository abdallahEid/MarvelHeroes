//
//  CharacterResponse.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    var id: Int
    var thumbnail: Image
    
    let name: String
    let description: String
    let resourceURI: String
}
