//
//  ListSongTableViewController.swift
//  Lapp
//
//  Created by Paul Geneve on 27/04/2022.
//

import UIKit

struct Song{
    let name: String
    let link: String
}
extension Song{
    init?(json: [String:Any]){
        guard let name = json["title"] as? String,
              let link = json["link"] as? String
        else{
            return nil
        }
        self.name = name
        self.link = link
    }
}

class ListSongTableViewController: UITableViewController {
    
    var idAlbum = 1234
    var nameAlbum = ""
    var linkArtist = ""
    var dataSource : [Song] = []
    
    override func viewDidLoad() {
        self.title = nameAlbum
        super.viewDidLoad()
        
        let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                let url = URL(string: "https://api.deezer.com/album/\(idAlbum)/tracks")!
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                            if let data = json as? [String: AnyObject] {
                                
                                if let items = data["data"] as? [[String: AnyObject]] {
                                    for item in items {
                                        
                                        //self.browser.append(item["link"]! as! String)
                                        if let song = Song(json: item) {
                                            self.dataSource.append(song)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "songReuseIdentifier", for: indexPath)
        cell.textLabel?.text = self.dataSource[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vcWeb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webview") as? ArtistInfoWebViewController{
            vcWeb.linkArtist = self.dataSource[indexPath.row].link
            self.present(vcWeb, animated: true, completion: nil)
        }
    }
    
    
}