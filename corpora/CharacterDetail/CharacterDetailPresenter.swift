//
//  CharacterDetailPresenter.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation

class CharacterDetailPresenter  {
    
    // MARK: Properties
    weak var view: CharacterDetailViewProtocol?
    var interactor: CharacterDetailInteractorInputProtocol?
    var wireFrame: CharacterDetailWireFrameProtocol?
    
}

extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension CharacterDetailPresenter: CharacterDetailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
