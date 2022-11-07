//
//  EpisodeCell.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//

import UIKit

class EpisodeCell : UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var air_date: UILabel!
    
    func ConfigureCell(model: Episode){
        title.text = model.name
        air_date.text = model.airDate
    }
    
}
