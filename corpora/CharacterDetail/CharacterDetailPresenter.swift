//
//  CharacterDetailPresenter.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation

class CharacterDetailPresenter : CharacterDetailPresenterProtocol {
    
    // MARK: Properties
    weak var view: CharacterDetailViewProtocol?
    var interactor: CharacterDetailInteractorInputProtocol?
    var wireFrame: CharacterDetailWireFrameProtocol?
    var character: Result?
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        
        if let _character = character {
            view?.setupView(title: _character.name)
            self.interactor?.fetchEpisodesData(episodes: _character.episode)
        }
    }
    
    func getSection(index: Int) -> Section? {
        return self.interactor?.sections[index]
    }
    
    func getEpisodeInSection(section: Int, index: Int) -> Episode {
        return (self.interactor?.sections[section].episodes[index])!
    }
    
    func getEpisodeCountInSection(index: Int) -> Int? {
        return self.interactor?.sections[index].episodes.count
    }
    
    func getSectionsCount() -> Int {
        return (self.interactor?.sections.count)!
    }
}

extension CharacterDetailPresenter: CharacterDetailInteractorOutputProtocol
{
    func fetchedEpisodesSuccess() {
        self.view?.updateData()
    }
    
    func fetchedEpisodesFailure(error: Error) {
        self.view?.showError(error: error)
    }
}
