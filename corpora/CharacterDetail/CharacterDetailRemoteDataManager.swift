//
//  CharacterDetailRemoteDataManager.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation

class CharacterDetailRemoteDataManager:CharacterDetailRemoteDataManagerInputProtocol {

    var remoteRequestHandler: CharacterDetailRemoteDataManagerOutputProtocol?
    
    func fetchEpisodiesFromService(episodes: [String]) {
        
        let service = NativeURLSessionNetworkService()
        NetWorkManager.init(wbs: service).apiCall_GetEpisodes(urlEpisodes: episodes) { results in
            self.remoteRequestHandler?.fetchedEpisodes(apiResponse: results)
        }
    }
}
