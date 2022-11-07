//
//  CharacterListView.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//  
//

import Foundation
import UIKit
import TagListView

class CharacterListView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterView: TagListView!
    
    // MARK: Properties
    var presenter: CharacterListPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
        
    }
}

extension CharacterListView: CharacterListViewProtocol {
    
    func setupFilters() {
        
        filterView.delegate = self
        
        filterView.textFont = UIFont.systemFont(ofSize: 18)
        
        filterView.alignment = .center
        
        filterView.addTag("Vivo")
        filterView.addTag("Muerto")
        filterView.addTag("Desconocido")
        filterView.addTag("Cualquiera")
        
        title = "Characters"
    }
    
    func setupCollection(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func updateFilters(filterApplied: String) {
        
        for tagview in self.filterView.tagViews{
            tagview.tagBackgroundColor = tagview.titleLabel?.text == filterApplied ? UIColor.lightGray : UIColor.white
        }
        
    }
    
    func updateData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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

// MARK: TAGVIEWLIST DELEGATE

extension CharacterListView: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        self.presenter?.viewChangedFilter(tag: title)
    }
    
}


// MARK: TABLEVIEW DELEGATES / DATASOURCE

extension CharacterListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
        
            return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 200)
    }
}

extension CharacterListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = self.presenter?.getCharacterCount() {
            return count
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterListCell
        
        if let modelRow = self.presenter?.getCharactersForIndexPath(index: indexPath.row) {
            cell.configureCell(model: modelRow)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.presenter?.viewNeedMoreCharacters(indexPath: indexPath.row)
    }
    
}

