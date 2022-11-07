//
//  CharacterDetailView.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//  
//

import Foundation
import UIKit

class CharacterDetailView: UIViewController {

    // MARK: Properties
    var presenter: CharacterDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CharacterDetailView: CharacterDetailViewProtocol {
    // TODO: implement view output methods
}
