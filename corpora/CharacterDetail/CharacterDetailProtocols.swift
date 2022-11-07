//
//  CharacterDetailProtocols.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation
import UIKit

protocol CharacterDetailViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: CharacterDetailPresenterProtocol? { get set }
}

protocol CharacterDetailWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createCharacterDetailModule() -> UIViewController
}

protocol CharacterDetailPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: CharacterDetailViewProtocol? { get set }
    var interactor: CharacterDetailInteractorInputProtocol? { get set }
    var wireFrame: CharacterDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol CharacterDetailInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol CharacterDetailInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: CharacterDetailInteractorOutputProtocol? { get set }
    var localDatamanager: CharacterDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol? { get set }
}

protocol CharacterDetailDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol CharacterDetailRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CharacterDetailRemoteDataManagerOutputProtocol? { get set }
}

protocol CharacterDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CharacterDetailLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
