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
    func setupFilters()
    func updateData()
    func showError(error: Error)
    func updateFilters(filterApplied: String)
}

protocol CharacterListWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCharacterListModule() -> UIViewController
        
    func showDetail(fromView: CharacterListViewProtocol, character: Result)
}

protocol CharacterListPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CharacterListViewProtocol? { get set }
    var interactor: CharacterListInteractorInputProtocol? { get set }
    var wireFrame: CharacterListWireFrameProtocol? { get set }
    
    // Update UI
    
    func viewDidLoad()
    func viewNeedMoreCharacters(indexPath: Int)
    func viewChangedFilter(tag: String)
    func viewDidSelectedCharacter(index: Int)
    
    // Accesors func
    
    func getCharacterCount() -> Int
    func getCharactersForIndexPath(index: Int) -> Result
}

protocol CharacterListInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func fetchedCharactersSuccess(characters: CharacterResponse,newPage: Bool)
    func fetchedCharactersFailure(error: Error)
}

protocol CharacterListInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CharacterListInteractorOutputProtocol? { get set }
    var localDatamanager: CharacterListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CharacterListRemoteDataManagerInputProtocol? { get set }
    
    func fetchCharacters(next: String?,filter: String?, query: String?)
}

protocol CharacterListDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CharacterListRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CharacterListRemoteDataManagerOutputProtocol? { get set }
    
    func fetchCharactersFromService(next: String?,filter: String?,query: String?)
}

protocol CharacterListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func fetchedCharacters(apiResponse : Swift.Result<CharacterResponse, Error>,newPage: Bool)
}

protocol CharacterListLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
