//
//  CharactListMVVMRouter.swift
//  corpora
//
//  Created by David Ortego Lucas on 19/11/22.
//

import Foundation
import UIKit

class CharacterListMVVMRouter {
    
    class func getViewController() -> UIViewController {
        return UIStoryboard(name: "CharacterListMVVM", bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterListMVVM")
    }
}
