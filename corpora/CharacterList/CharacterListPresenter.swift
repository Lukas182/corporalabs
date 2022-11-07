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
    var tagFiltering = ""
    
    // MARK: Properties
    weak var view: CharacterListViewProtocol?
    var interactor: CharacterListInteractorInputProtocol?
    var wireFrame: CharacterListWireFrameProtocol?
    
}

extension CharacterListPresenter: CharacterListPresenterProtocol {

    
    // Presenter methods
    
    func viewDidLoad() {

        view?.setupCollection()
        view?.setupFilters()
        
        interactor?.fetchCharacters(next: nil,filter: nil,query: nil)
        
    }
    
    func viewNeedMoreCharacters(indexPath: Int) {
   
        let count = self.getCharacterCount()
        if(count != 0)
        {
            if (indexPath == count - 1 ) {
                interactor?.fetchCharacters(next: info.next,filter: nil,query: nil)
            }
        }
        
    }
    
    func viewChangedFilter(tag: String) {
        
        tagFiltering = tagFiltering == tag ? "" : tag
        
        self.view?.updateFilters(filterApplied: tagFiltering)
        switch tagFiltering
        {
            case "Vivo": interactor?.fetchCharacters(next: nil,filter: "alive",query: "status")
            break
            case "Muerto": interactor?.fetchCharacters(next: nil,filter: "dead",query: "status")
            break
            case "Desconocido": interactor?.fetchCharacters(next: nil,filter: "unknown",query: "status")
            break
            case "Cualquiera": interactor?.fetchCharacters(next: nil,filter: nil,query: nil)
            break
            default: interactor?.fetchCharacters(next: nil,filter: nil,query: nil)
        }
    }
    
    // Getters from View
    
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
