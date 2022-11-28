//
//  CharacterListMVVMView.swift
//  corpora
//
//  Created by David Ortego Lucas on 19/11/22.
//

import UIKit
import SDWebImage
import TagListView

class CharacterListMVVMView: UIViewController {
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterView: TagListView!
    
    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureFilters()
        bind()
    }
    
    private func configureView()
    {
        viewModel.retrieveData(nextPage: nil)
    
        activityLoader.startAnimating()
        activityLoader.isHidden = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func configureFilters() {
        
        filterView.delegate = self
        
        filterView.textFont = UIFont.systemFont(ofSize: 18)
        
        filterView.alignment = .center
        
        filterView.addTag("Vivo")
        filterView.addTag("Muerto")
        filterView.addTag("Desconocido")
        filterView.addTag("Cualquiera")
        
        self.title = "Characters"
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                
                self?.activityLoader.stopAnimating()
                self?.activityLoader.isHidden = true
                
                self?.collectionView.reloadData()
            }
        }
    }
}

extension CharacterListMVVMView: UICollectionViewDelegateFlowLayout {
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

extension CharacterListMVVMView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterListCell
        
        let model = viewModel.dataArray[indexPath.row]
        
        cell.backgroundColor = UIColor.lightGray
        
        cell.name.text = model.name
        cell.origin.text = model.location.name
        cell.status.text = model.status
        
        cell.img.sd_setImage(with: URL.init(string: model.image), placeholderImage:nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.viewNeedMoreCharacters(index: indexPath.row)
    }
    
}

extension CharacterListMVVMView: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        viewModel.filterData(title: title)
        
        let topRow = IndexPath(row: 0,section: 0)
                  
        self.collectionView.scrollToItem(at: topRow, at: .top, animated: false)
        
        for _tagview in self.filterView.tagViews{
            _tagview.tagBackgroundColor = UIColor.white
        }
        
        tagView.tagBackgroundColor = (viewModel.filtering == nil) ? UIColor.white : UIColor.lightGray
        
    }
}
