//
//  SongViewController.swift
//  Lapp
//
//  Created by Paul Geneve on 29/04/2022.
//

import UIKit
import AVFoundation

class SongViewController: UIViewController {
    
    var avPlayer: AVPlayer?
    var avPlayerItem: AVPlayerItem?
    
    var songImage = ""
    var nameArtist = ""
    var titleSong = ""
    var urlString = ""
    
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var nameArtistLabel: UILabel!
    @IBOutlet weak var titleSongLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: urlString)
        print("playing \(String(describing: url))")
        
        avPlayerItem = AVPlayerItem.init(url: url! as URL)
        avPlayer = AVPlayer.init(playerItem: avPlayerItem)
        avPlayer?.volume = 1.0
        
        songImageView.loadFrom(URLAddress: songImage)
        nameArtistLabel.text = "Artist :\(nameArtist)"
        titleSongLabel.text = "Morceaux :\(titleSong)"
        
    }
    
    @IBAction func playButton(_ sender: Any) {
        avPlayer?.play()
    }
    @IBAction func pauseButton(_ sender: Any) {
        avPlayer?.pause()
    }
}


