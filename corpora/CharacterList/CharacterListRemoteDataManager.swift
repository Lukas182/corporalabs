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
    
    func fetchCharactersFromService(next: String?,filter: String?,query: String?) {
        
        let service = NativeURLSessionNetworkService()
        NetWorkManager.init(wbs: service).apiCall_GetCharacters(next: next,filter: filter, query: query) { result in
            self.remoteRequestHandler?.fetchedCharacters(apiResponse: result,newPage: next != nil ? true : false)
        }
        
    }
    
}
