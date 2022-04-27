//
//  ArtistCollectionViewCell.swift
//  Lapp
//
//  Created by FabalaAdmin on 4/27/22.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ArtistLabel: UILabel!
    func configure (with artist: String){
        ArtistLabel.text = artist
    }
}
