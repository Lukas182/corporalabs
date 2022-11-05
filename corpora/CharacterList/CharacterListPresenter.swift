//
//  CharacterListPresenter.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation

class CharacterListPresenter  {
    
    var characters = [Result]()
    
    // MARK: Properties
    weak var view: CharacterListViewProtocol?
    var interactor: CharacterListInteractorInputProtocol?
    var wireFrame: CharacterListWireFrameProtocol?
    
}

extension CharacterListPresenter: CharacterListPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {

        view?.setupCollection()
        interactor?.fetchCharacters()
        
    }
    
    func getCharacterCount() -> Int {
        return self.characters.count
    }
    
    func getCharactersForIndexPath(index: Int) -> Result {
        return self.characters[index]
    }
    
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    
    func fetchedCharactersSuccess(characters: CharacterResponse) {
        self.characters = characters.results
        self.view?.updateData(characters: self.characters)
    }
    
    func fetchedCharactersFailure(error: Error) {
        self.view?.showError(error: error)
    }
    
    
    
}
