//  
//  CharacterListMVVMViewController.swift
//  corpora
//
//  Created by David Ortego Lucas on 19/11/22.
//

import UIKit

class CharacterListMVVMViewController: UIViewController {

    var viewModel: CharacterListMVVMViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewModelDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewModelWillAppear()
    }
    
    fileprivate func bindViewModel() {

        viewModel.output = { [unowned self] output in
            //handle all your bindings here
            switch output {
            default:
                break
            }
        }
    }
}
