//
//  ArtistCollectionViewCell.swift
//  Lapp
//
//  Created by FabalaAdmin on 4/27/22.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ArtistImageView: UIImageView!
    @IBOutlet weak var ArtistLabel: UILabel!
    
    
    func configure (artist: String, imageArtist: String){
        ArtistLabel.text = artist
        ArtistImageView.loadFrom(URLAddress: imageArtist)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
