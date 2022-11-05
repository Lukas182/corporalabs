//
//  CharacterListProtocols.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation
import UIKit

protocol CharacterListViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CharacterListPresenterProtocol? { get set }
    
    func setupCollection()
    func updateData(characters: [Result])
    func showError(error: Error)
}

protocol CharacterListWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCharacterListModule() -> UIViewController
}

protocol CharacterListPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CharacterListViewProtocol? { get set }
    var interactor: CharacterListInteractorInputProtocol? { get set }
    var wireFrame: CharacterListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getCharacterCount() -> Int
    func getCharactersForIndexPath(index: Int) -> Result
}

protocol CharacterListInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func fetchedCharactersSuccess(characters: CharacterResponse)
    func fetchedCharactersFailure(error: Error)
}

protocol CharacterListInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CharacterListInteractorOutputProtocol? { get set }
    var localDatamanager: CharacterListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CharacterListRemoteDataManagerInputProtocol? { get set }
    
    func fetchCharacters()
}

protocol CharacterListDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CharacterListRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CharacterListRemoteDataManagerOutputProtocol? { get set }
    
    func fetchCharactersFromService()
}

protocol CharacterListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func fetchedCharacters(apiResponse : Swift.Result<CharacterResponse, Error>)
}

protocol CharacterListLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
