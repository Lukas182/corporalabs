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
}

protocol CharacterListInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol CharacterListInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CharacterListInteractorOutputProtocol? { get set }
    var localDatamanager: CharacterListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CharacterListRemoteDataManagerInputProtocol? { get set }
}

protocol CharacterListDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CharacterListRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CharacterListRemoteDataManagerOutputProtocol? { get set }
}

protocol CharacterListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CharacterListLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
