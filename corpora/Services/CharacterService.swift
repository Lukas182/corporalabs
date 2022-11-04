//
//  CharacterService.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getCharacters() -> Bool
}

class NativeURLSessionNetworkService : NetWorkServiceProtocol {
    func getCharacters() -> Bool {
        
        URLSession.init(configuration: .default).dataTask(with: URL.init(string: "https://rickandmortyapi.com/api/character")!) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse
            {
                print(httpResponse.statusCode)
                
                do {
                    if let _data = data {
                        let json = try JSONDecoder().decode(CharacterResponse.self, from: _data)
                        print(json)
                    }
                }
                catch (let error){
                    print(error)
                }
            }
        }.resume()
        
        return true
    }
    
    
}

class NetWorkManager {
    
    private let webservice : NetWorkServiceProtocol
    
    init(wbs : NetWorkServiceProtocol)
    {
        self.webservice = wbs
    }
    
    func callService() -> Bool {
        return self.webservice.getCharacters()
    }
    
}
