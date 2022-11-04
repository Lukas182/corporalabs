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

}

extension CharacterListInteractor: CharacterListRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
