//
//  CharacterListPresenter.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation

class CharacterListPresenter  {
    
    // MARK: Properties
    weak var view: CharacterListViewProtocol?
    var interactor: CharacterListInteractorInputProtocol?
    var wireFrame: CharacterListWireFrameProtocol?
    
}

extension CharacterListPresenter: CharacterListPresenterProtocol {
    
    // Presenter methods
    
    func viewDidLoad() {
        DispatchQueue.main.async {
            self.view?.setupCollection()
            self.view?.setupFilters()
            self.view?.showLoader()
        
            self.interactor?.fetchCharacters(next: nil,filter: nil,query: nil)
        }
    }
    
    func viewNeedMoreCharacters(indexPath: Int) {
        self.interactor?.loadMoreCharacters(index: indexPath)
    }
    
    func viewChangedFilter(tag: String) {
        self.interactor?.filteringCharacters(tag: tag)
        self.view?.updateData()
        self.view?.updateFilters(filterApplied: self.interactor!.tagFiltering)
    }
    
    func viewDidSelectedCharacter(index: Int) {
        self.wireFrame?.showDetail(fromView: view!, character: (self.interactor?.characters[index])!)
    }
    
    // Getters from View
    
    func getCharacterCount() -> Int {
        return (self.interactor?.characters.count)!
    }
    
    func getCharactersForIndexPath(index: Int) -> Result? {
        if( (self.interactor?.characters.count)!>0)
        {
            if let _character = self.interactor?.characters[index]{
                return _character
            }
        }
        return nil
    }
    
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {    
    
    func fetchedCharactersSuccess(newPage: Bool) {
        self.view?.hideLoader()
        self.view?.updateData()
    }
    
    func fetchedCharactersFailure(error: Error) {
        self.view?.hideLoader()
        self.view?.showError(error: error)
    }
    
}
