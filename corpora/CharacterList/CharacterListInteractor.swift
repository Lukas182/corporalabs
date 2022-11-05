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

    func fetchCharacters() {
        remoteDatamanager?.fetchCharactersFromService()
    }
}

extension CharacterListInteractor: CharacterListRemoteDataManagerOutputProtocol {
    func fetchedCharacters(apiResponse: Swift.Result<CharacterResponse, Error>) {
        switch apiResponse {
        case .success(let characters):
            presenter?.fetchedCharactersSuccess(characters: characters)
        case .failure(let error):
            presenter?.fetchedCharactersFailure(error: error)
        }
    }
    

    
    // TODO: Implement use case methods
}
