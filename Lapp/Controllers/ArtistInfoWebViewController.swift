//
//  ArtistInfoWebViewController.swift
//  Lapp
//
//  Created by Paul Geneve on 28/04/2022.
//

import UIKit
import WebKit

class ArtistInfoWebViewController: UIViewController {

   
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var linkArtist = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Info Artists"
        
        self.reloadWebView(text: linkArtist)
        self.searchTextField.text = self.linkArtist
        // Do any additional setup after loading the view.
    }
    
    func reloadWebView(text: String){
        let url = URL(string: text)!
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    @IBAction func navigateWebButton(_ sender: Any) {
        self.reloadWebView(text: self.searchTextField.text!)
    }
    
    @IBAction func closePageButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
