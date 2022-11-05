//
//  CharacterService.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getCharacters(completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void )
}

class NativeURLSessionNetworkService : NetWorkServiceProtocol {
    
    func getCharacters(completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void) {
        
        guard Reachability.isConnectedToNetwork(),
            let url = URL(string: EndPoint.characters.url) else {
                completion(.failure(CustomError.noConnection))
                return
        }
        
        var request = URLRequest(url: url)
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
    
    func apiCall_GetCharacters(completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void) {
        return self.webservice.getCharacters { result in
            completion(result)
        }
    }
    
}
