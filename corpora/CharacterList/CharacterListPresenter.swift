//
//  CharacterListPresenter.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation

class CharacterListPresenter  {
    
    var info = Info()
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
        interactor?.fetchCharacters(next: nil)
        
    }
    
    func viewNeedMoreCharacters(indexPath: Int) {
   
        let count = self.getCharacterCount()
        if(count != 0)
        {
            if (indexPath == count - 1 ) {
                interactor?.fetchCharacters(next: info.next)
            }
        }
        
    }
    
    func getCharacterCount() -> Int {
        return self.characters.count
    }
    
    func getCharactersForIndexPath(index: Int) -> Result {
        return self.characters[index]
    }
    
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {    
    
    func fetchedCharactersSuccess(characters: CharacterResponse, newPage: Bool) {
        if(newPage == true)
        {
            self.characters.append(contentsOf: characters.results)
        }
        else
        {
            self.characters = characters.results
        }
        self.info = characters.info
        self.view?.updateData()
    }
    
    func fetchedCharactersFailure(error: Error) {
        self.view?.showError(error: error)
    }
    
    
    
}
