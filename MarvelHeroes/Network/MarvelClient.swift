//
//  MarvelClient.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

class MarvelClient{
    
    enum HTTPMethod:String{
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum EndPoint{
        static let baseUrl = ""
        static let baseApiURL = EndPoint.baseUrl + "/api"
        
        var stringValue:String{
            switch self {
                
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
            print("Failed in decoding: \(error)")
            return nil
        }
    }
}



