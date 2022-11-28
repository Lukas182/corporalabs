//  
//  CharacterListMVVMBuilder.swift
//  corpora
//
//  Created by David Ortego Lucas on 19/11/22.
//

import Foundation
import UIKit

class CharacterListMVVMBuilder {

    func build(with navigationController: UINavigationController?) -> UIViewController {
        
        let viewController = getStoryBoard().instantiateViewController(withIdentifier: "CharacterList") as! CharacterListMVVMViewController
        let coordinator = CharacterListMVVMRouter(navigationController: navigationController)
        let viewModel = CharacterListMVVMViewModelImpl(router: coordinator)

        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func getNavController() -> UINavigationController {
        let navController = getStoryBoard().instantiateViewController(withIdentifier: "CharacterListMVVMViewController")
        return navController as! UINavigationController
    }
    
    func getStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "CharacterListMVVM", bundle: Bundle.main)
    }
}
