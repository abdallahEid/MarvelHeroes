//
//  CharactersAPIs.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/2/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

class CharactersAPIs {
    
    let marvelClient = MarvelClient()
    
    func getCharacters(limit: Int = 20, offset: Int = 0, nameStartsWith: String? = nil , completion: @escaping ([CharacterResponse]?, Error?) -> Void) {
        marvelClient.request(url: MarvelClient.Endpoints.getCharacters(nameStartsWith, limit, offset).url , httpMethod: .get) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let marvelResponse = self.marvelClient.decode(type: MarvelResponse<DataResponse<CharacterResponse>>.self, data: data)

            completion(marvelResponse?.data.results, nil)

        }
        
    }
    
    func getCharacterSource(url: URL, completion: @escaping ([CharacterSourceResponse]?, Error?) -> Void){
        marvelClient.request(url: url, httpMethod: .get) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
           
            let marvelResponse = self.marvelClient.decode(type: MarvelResponse<DataResponse<CharacterSourceResponse>>.self, data: data)
            
            completion(marvelResponse?.data.results, nil)
        }
    }
}
