//
//  CharacterService.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getCharacters(next: String? , filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void )
}

class NativeURLSessionNetworkService : NetWorkServiceProtocol {
    
    func getCharacters(next: String? , filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void ) {
        
        var url = next != nil ? next! : EndPoint.characters.url
        
        if let _query = query,let _filter = filter {
            url = url.appending("?").appending(_query).appending("=").appending(_filter)
        }
        
        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(CustomError.noConnection))
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode != 200){
                    completion(.failure(CustomError.failedRequest))
                    return
                }
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
}

class NetWorkManager {
    
    private let webservice : NetWorkServiceProtocol
    
    init(wbs : NetWorkServiceProtocol)
    {
        self.webservice = wbs
    }
    
    func apiCall_GetCharacters(next: String?, filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void) {
        return self.webservice.getCharacters(next: next, filter: filter, query: query) { result in
            completion(result)
        }
    }
    
}
