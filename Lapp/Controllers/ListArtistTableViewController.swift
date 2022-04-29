//
//  ListArtistTableViewController.swift
//  Lapp
//
//  Created by Paul Geneve on 29/04/2022.
//

import UIKit
import Foundation

struct Artistlink{
    let name: String
    let link: String
    let id: Int
}
extension Artistlink{
    init?(json: [String:Any]){
        guard let name = json["name"] as? String,
              let link = json["link"] as? String,
              let id = json["id"] as? Int
        else {
            return nil
        }
        self.name = name
        self.link = link
        self.id = id
    }
}

class ListArtistTableViewController: UITableViewController {
    
    var dataSource : [Artistlink] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Informations Artist"
        
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
                                        if let artist = Artistlink(json: item) {
                                            self.dataSource.append(artist)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistReusible", for: indexPath)
        
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
