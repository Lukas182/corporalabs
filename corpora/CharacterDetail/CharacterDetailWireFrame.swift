//
//  CharacterDetailWireFrame.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation
import UIKit

class CharacterDetailWireFrame: CharacterDetailWireFrameProtocol {

    class func createCharacterDetailModule(character: Result) -> UIViewController {
        let detailView = mainStoryboard.instantiateViewController(withIdentifier: "CharacterDetailView")
        if let view = detailView as? CharacterDetailView {
            let presenter: CharacterDetailPresenterProtocol & CharacterDetailInteractorOutputProtocol = CharacterDetailPresenter()
            let interactor: CharacterDetailInteractorInputProtocol & CharacterDetailRemoteDataManagerOutputProtocol = CharacterDetailInteractor()
            let localDataManager: CharacterDetailLocalDataManagerInputProtocol = CharacterDetailLocalDataManager()
            let remoteDataManager: CharacterDetailRemoteDataManagerInputProtocol = CharacterDetailRemoteDataManager()
            let wireFrame: CharacterDetailWireFrameProtocol = CharacterDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            presenter.character = character
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return detailView
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "CharacterDetailView", bundle: Bundle.main)
    }
    
}
