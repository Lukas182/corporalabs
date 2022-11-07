//
//  CharacterDetailPresenter.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation

struct Section {
    var title: String
    var episodes: [Episode]
}

class CharacterDetailPresenter : CharacterDetailPresenterProtocol {
    
    // MARK: Properties
    weak var view: CharacterDetailViewProtocol?
    var interactor: CharacterDetailInteractorInputProtocol?
    var wireFrame: CharacterDetailWireFrameProtocol?
    var character: Result?
    var sections: [Section]?
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        
        if let _character = character {
            view?.setupView(title: _character.name)
        }
    }
    
}

extension CharacterDetailPresenter: CharacterDetailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
