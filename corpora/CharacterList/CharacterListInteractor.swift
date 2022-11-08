//
//  CharacterListInteractor.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation

class CharacterListInteractor: CharacterListInteractorInputProtocol {
    

    // MARK: Properties
    weak var presenter: CharacterListInteractorOutputProtocol?
    var localDatamanager: CharacterListLocalDataManagerInputProtocol?
    var remoteDatamanager: CharacterListRemoteDataManagerInputProtocol?
    
    var info: Info?
    var characters: [Result] = [Result]()
    var tagFiltering = ""
    
    func fetchCharacters(next: Bool?,filter: String?, query: String?) {
        remoteDatamanager?.fetchCharactersFromService(next: nil,filter: filter, query: query)
    }
    
    func filteringCharacters(tag: String) {
        
        characters.removeAll()
        info = nil
        
        tagFiltering = tagFiltering == tag ? "" : tag
        
        switch tagFiltering
        {
            case "Vivo":
                remoteDatamanager?.fetchCharactersFromService(next: nil,filter: "alive", query: "status")
            break
            case "Muerto":
                remoteDatamanager?.fetchCharactersFromService(next: nil,filter: "dead", query: "status")
            break
            case "Desconocido":
                remoteDatamanager?.fetchCharactersFromService(next: nil,filter: "unknown", query: "status")
            break
            default:
                remoteDatamanager?.fetchCharactersFromService(next: nil,filter: nil, query: nil)
        }
    }
    
    func loadMoreCharacters(index: Int) {
        let count = characters.count
        if(count != 0)
        {
            if (index == count - 1 ) {
                remoteDatamanager?.fetchCharactersFromService(next: info?.next,filter: nil, query: nil)
            }
        }
    }
}

extension CharacterListInteractor: CharacterListRemoteDataManagerOutputProtocol {
    func fetchedCharacters(apiResponse: Swift.Result<CharacterResponse, Error>,newPage: Bool) {
        switch apiResponse {
        case .success(let charactersResponse):
            if(newPage == true)
            {
                self.characters.append(contentsOf: charactersResponse.results)
            }
            else
            {
                self.characters = charactersResponse.results
            }
            self.info = charactersResponse.info
            presenter?.fetchedCharactersSuccess(newPage: newPage)
        case .failure(let error):
            presenter?.fetchedCharactersFailure(error: error)
        }
    }
    

    
    // TODO: Implement use case methods
}
