//
//  CharacterListCell.swift
//  corpora
//
//  Created by David Ortego Lucas on 5/11/22.
//

import UIKit
import SDWebImage

class CharacterListCell : UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.img.layer.cornerRadius = 50
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 3.0
        self.img.layer.borderColor = UIColor.white.cgColor
    }
    
    override func prepareForReuse() {
        
        self.img.image = nil
        self.name.text = ""
        self.origin.text = ""
        self.status.text = ""
        
        super.prepareForReuse()
    }
    
    func configureCell(model: Result){
        
        self.backgroundColor = UIColor.lightGray
        
        self.name.text = model.name
        self.origin.text = model.location.name
        self.status.text = model.status
        
        self.img.sd_setImage(with: URL.init(string: model.image), placeholderImage:nil)
        
    }
    
}
