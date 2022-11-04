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
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
