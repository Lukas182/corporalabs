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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
}

extension CharacterDetailView: CharacterDetailViewProtocol {
    
    func setupView(title: String) {
        self.title = title
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.activityLoader.startAnimating()
            self.activityLoader.isHidden = false
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityLoader.stopAnimating()
            self.activityLoader.isHidden = true
        }
    }
    
    func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Something Went Wrong :(", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension CharacterDetailView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.presenter?.getSectionsCount())!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.presenter?.getEpisodeCountInSection(index: section))!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.presenter?.getSection(index: section))?.season
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodeCell
        cell.ConfigureCell(model:  (self.presenter?.getEpisodeInSection(section: indexPath.section, index: indexPath.row))!)
        return cell
    }

}

extension CharacterDetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
