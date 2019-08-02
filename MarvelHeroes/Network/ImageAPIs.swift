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
    
    let marvelClient = MarvelClient()

    func downloadImageFrom(url: URL,  completion: @escaping (UIImage?, Error?) -> Void) {
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let cachedImage = UIImage(data: data){
            completion(cachedImage, nil)

        } else {
            marvelClient.request(url: url , httpMethod: .get) { (data, response, error) in
                guard let data = data, let response = response else {
                    completion(nil, error)
                    return
                }
                guard let image = UIImage(data: data) else {
                    completion(nil, error)
                    return
                }
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                print("Downloaded", url.absoluteString)
                completion(image, nil)
            }
        }
        
    }

}
