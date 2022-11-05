//
//  CharacterListRemoteDataManager.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation

class CharacterListRemoteDataManager:CharacterListRemoteDataManagerInputProtocol {
    
    
    var remoteRequestHandler: CharacterListRemoteDataManagerOutputProtocol?
    
    func fetchCharactersFromService() {
        
        let service = NativeURLSessionNetworkService()
        NetWorkManager.init(wbs: service).apiCall_GetCharacters { result in
            self.remoteRequestHandler?.fetchedCharacters(apiResponse: result)
        }
        
    }
    
}
