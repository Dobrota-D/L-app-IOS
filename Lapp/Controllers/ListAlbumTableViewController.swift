//
//  ListAlbumTableViewController.swift
//  Lapp
//
//  Created by Paul Geneve on 27/04/2022.
//

import UIKit
import Foundation

struct Album{
    let name: String
    let link: String
    let id: Int
}
extension Album{
    init?(json: [String:Any]){
        guard let name = json["title"] as? String,
              let link = json["link"] as? String,
              let id = json["id"] as? Int
        else{
            return nil
        }
        self.name = name
        self.link = link
        self.id = id
    }
}

class ListAlbumTableViewController: UITableViewController {
    
    var idArtist = 1234
    var nameArtist = ""
    var linkArtist = ""
    var dataSource : [Album] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = nameArtist
        
                
        let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)

                let url = URL(string: "https://api.deezer.com/artist/\(idArtist)/albums")!

                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                            if let data = json as? [String: AnyObject] {

                                if let items = data["data"] as? [[String: AnyObject]] {
                                    for item in items {
                                        //self.browser.append(item["link"]! as! String)
                                        if let album = Album(json: item) {
                                            self.dataSource.append(album)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                }
                task.resume()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = self.dataSource[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listSong") as? ListSongTableViewController{
            vc.linkArtist = self.linkArtist
            vc.idAlbum = self.dataSource[indexPath.row].id
            vc.nameAlbum = self.dataSource[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
//            if else vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "infoArtist") as? ArtistInfoWebViewController {
//            self.navigationController?.present(vc2, animated: true, completion: nil)
//        }
    }
    
}
