//
//  CharacterListWireFrame.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation
import UIKit

class CharacterListWireFrame: CharacterListWireFrameProtocol {

    class func createCharacterListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "CharacterListView")
        if let view = navController.children.first as? CharacterListView {
            let presenter: CharacterListPresenterProtocol & CharacterListInteractorOutputProtocol = CharacterListPresenter()
            let interactor: CharacterListInteractorInputProtocol & CharacterListRemoteDataManagerOutputProtocol = CharacterListInteractor()
            let localDataManager: CharacterListLocalDataManagerInputProtocol = CharacterListLocalDataManager()
            let remoteDataManager: CharacterListRemoteDataManagerInputProtocol = CharacterListRemoteDataManager()
            let wireFrame: CharacterListWireFrameProtocol = CharacterListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "CharacterListView", bundle: Bundle.main)
    }
    
    func showDetail(fromView: CharacterListViewProtocol, character: Result) {
        
        let detailView = CharacterDetailWireFrame.createCharacterDetailModule(character: character)
        
        if let sourceView = fromView as? UIViewController {
            sourceView.navigationController?.pushViewController(detailView, animated: true)
        }
        
    }
    
}
