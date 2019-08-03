//
//  CharacterSourceResponse.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

enum CharacterSourceType: String {
    case comics = "comics"
    case series = "series"
    case stories = "stories"
    case events = "events"
}

struct CharacterSourceResponse: Codable {
    var id: Int?
    var thumbnail: Image?

    let title: String?
    let images: [Image]?
    let resourceURI: String?
}
