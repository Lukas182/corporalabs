//
//  CharacterDetailProtocols.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation
import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CharacterDetailPresenterProtocol? { get set }
    
    func setupView(title: String)
}

protocol CharacterDetailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCharacterDetailModule(character: Result) -> UIViewController
}

protocol CharacterDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CharacterDetailViewProtocol? { get set }
    var interactor: CharacterDetailInteractorInputProtocol? { get set }
    var wireFrame: CharacterDetailWireFrameProtocol? { get set }
    var character: Result? { get set }
    
    func viewDidLoad()
}

protocol CharacterDetailInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol CharacterDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CharacterDetailInteractorOutputProtocol? { get set }
    var localDatamanager: CharacterDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol? { get set }
}

protocol CharacterDetailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CharacterDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CharacterDetailRemoteDataManagerOutputProtocol? { get set }
}

protocol CharacterDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CharacterDetailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
