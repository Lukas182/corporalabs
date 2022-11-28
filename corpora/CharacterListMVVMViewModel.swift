//  
//  CharacterListMVVMViewModel.swift
//  corpora
//
//  Created by David Ortego Lucas on 19/11/22.
//

import Foundation

typealias CharacterListMVVMViewModelOutput = (CharacterListMVVMViewModelImpl.Output) -> Void

protocol CharacterListMVVMViewModelInput {
    
}

protocol CharacterListMVVMViewModel {
    var output: CharacterListMVVMViewModelOutput? { get set}
    
    func viewModelDidLoad()
    func viewModelWillAppear()
}

class CharacterListMVVMViewModelImpl: CharacterListMVVMViewModel, CharacterListMVVMViewModelInput {

    private let router: CharacterListMVVMRouter
    var output: CharacterListMVVMViewModelOutput?
    
    init(router: CharacterListMVVMRouter) {
        self.router = router
    }
    
    func viewModelDidLoad() {
        
    }
    
    func viewModelWillAppear() {
        
    }
    
    //For all of your viewBindings
    enum Output {
        
    }
}

extension CharacterListMVVMViewModelImpl {

}
