//
//  Image.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

struct Image: Codable {
    let path: String
    let imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    var url: URL {
        return URL(string: path + "." + imageExtension)!
    }
}
