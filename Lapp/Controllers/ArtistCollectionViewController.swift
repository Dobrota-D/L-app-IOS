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
}
extension Artist{
    init?(json: [String:Any]){
        guard let name = json["name"] as? String,
              let link = json["link"] as? String
        else{
            return nil
        }
        self.name = name
        self.link = link
    }
}

private let reuseIdentifier = "Cell"

class ArtistCollectionViewController: UICollectionViewController {
    
    var dataSource : [Artist] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        
        //connection API Deezer recupere l'URL qui retourne un dictionnaire, data --> renvoie un tableau de dictionnaire
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
                                        print(item["name"]!)
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
        
        // Register cell classes
        // self.collectionView!.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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
            artistCell.configure(with: dataSource[indexPath.row].name)
            cell = artistCell
        }
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
