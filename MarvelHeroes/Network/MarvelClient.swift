//
//  MarvelClient.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

class MarvelClient{

    static let apiKey = "57f470d09f0b94f6edc325acde1e7884"
    static let hash = "92da4c1ab014c6e32e5cd41b7d186d0d"
    static let ts = 1

    enum HTTPMethod:String{
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum Endpoints{
        static let baseUrl = "https://gateway.marvel.com/v1/public"
        static let apiKeyParam = "?ts=\(MarvelClient.ts)&apikey=\(MarvelClient.apiKey)&hash=\(MarvelClient.hash)"
        
        case getCharacters(String?, Int, Int)
        
        var stringValue:String{
            switch self {
            case .getCharacters(let nameStartsWith, let limit, let offset):
                return Endpoints.baseUrl + "/characters\(Endpoints.apiKeyParam)&limit=\(limit)&offset=\(offset)" + (nameStartsWith != nil ? "&nameStartsWith=\(nameStartsWith!)": "")
            }
            
        }
        
        var url:URL{
            return URL(string: stringValue)!
        }
    }
    
    func request(url:URL,httpMethod:HTTPMethod,parameters:[String:Any] = [:],headers:[String:String] = ["Accept":"application/json","Content-Type":"application/json"],completion: @escaping (Data?,URLResponse?,Error?)-> Void){
        
        var request = URLRequest(url:url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        if  httpMethod != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any , options:  .prettyPrinted)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data , response, error) in
            DispatchQueue.main.async {
                completion(data,response,error)
            }
        }
        
        task.resume()
        
    }
    
    func decode<T:Codable> (type:T.Type , data:Data)->T?{
        let decoder = JSONDecoder()
        do{
            let object = try decoder.decode(type.self, from: data)
            return object
        }catch{
            return nil
        }
    }
}



