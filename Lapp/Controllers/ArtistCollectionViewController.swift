//
//  ArtistCollectionViewController.swift
//  Lapp
//
//  Created by admin on 27/04/2022.
//

import UIKit
import Foundation

//struct
struct Artist{
    let name: String
    let link: String
    let id: Int
    let image: String
}
extension Artist{
    init?(json: [String:Any]){
        guard let name = json["name"] as? String,
              let link = json["link"] as? String,
              let id = json["id"] as? Int,
              let image = json["picture"] as? String
        else{
            return nil
        }
        self.name = name
        self.link = link
        self.id = id
        self.image = image
    
    }
}

private let reuseIdentifier = "Cell"

class ArtistCollectionViewController: UICollectionViewController {
    
    var dataSource : [Artist] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Artist"
        
        let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                let url = URL(string: "https://api.deezer.com/search/artist?q=a")!
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                            if let data = json as? [String: AnyObject] {
                                
                                if let items = data["data"] as? [[String: AnyObject]] {
                                    for item in items {
                                        //self.browser.append(item["link"]! as! String)
                                        if let artist = Artist(json: item) {
                                            self.dataSource.append(artist)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
                task.resume()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = ArtistCollectionViewCell()
        if let artistCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ArtistCollectionViewCell {
            artistCell.configure(artist: dataSource[indexPath.row].name, imageArtist: dataSource[indexPath.row].image)
                 cell = artistCell
             }
        // Configure the cell
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listAlbum") as? ListAlbumTableViewController{
            vc.idArtist = self.dataSource[indexPath.row].id
            vc.nameArtist = self.dataSource[indexPath.row].name
            vc.linkArtist = self.dataSource[indexPath.row].link
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


