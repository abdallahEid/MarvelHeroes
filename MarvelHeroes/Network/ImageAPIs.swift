//
//  ImageAPIs.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/2/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

class ImageAPIs {
    
    private let marvelClient = MarvelClient()

    func downloadImageFrom(url: URL,  completion: @escaping (Data?, Error?) -> Void) {
        marvelClient.request(url: url , httpMethod: .get) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
    }

}
