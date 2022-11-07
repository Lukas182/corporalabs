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
    func showError(error: Error)
    func updateData()
    
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
    var character : Result? { get set }
    
    func viewDidLoad()
    
    func getSection(index: Int) -> Section? 
    func getEpisodeCountInSection(index: Int) -> Int?
    func getEpisodeInSection(section: Int, index: Int) -> Episode
    func getSectionsCount() -> Int
}

protocol CharacterDetailInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    
    func fetchedEpisodesSuccess()
    func fetchedEpisodesFailure(error: Error)
    
    
}

protocol CharacterDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CharacterDetailInteractorOutputProtocol? { get set }
    var localDatamanager: CharacterDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CharacterDetailRemoteDataManagerInputProtocol? { get set }
    
    var episodes : [Episode]? { get set }
    var sections : [Section] { get set }
    
    func fetchEpisodesData(episodes : [String])
}

protocol CharacterDetailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CharacterDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CharacterDetailRemoteDataManagerOutputProtocol? { get set }
    
    func fetchEpisodiesFromService(episodes : [String])
}

protocol CharacterDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func fetchedEpisodes(apiResponse : Swift.Result<[Episode], Error>)
}

protocol CharacterDetailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
