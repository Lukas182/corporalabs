//
//  CharacterDetailInteractor.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CharacterDetailInteractorOutputProtocol?
    var localDatamanager: CharacterDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol?

}

extension CharacterDetailInteractor: CharacterDetailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
