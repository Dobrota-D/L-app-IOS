//
//  SongViewController.swift
//  Lapp
//
//  Created by Paul Geneve on 27/04/2022.
//

import UIKit
import AVFoundation

class SongViewController: UIViewController {
    var avPlayer:AVPlayer?
    var avPlayerItem:AVPlayerItem?
    
    override func viewDidLoad() {
       super.viewDidLoad()
           let urlstring = "https://s3.amazonaws.com/kargopolov/kukushka.mp3"
           let url = NSURL(string: urlstring)
           print("playing \(String(describing: url))")

           avPlayerItem = AVPlayerItem.init(url: url! as URL)
           avPlayer = AVPlayer.init(playerItem: avPlayerItem)
           avPlayer?.volume = 1.0

       }
 
    @IBAction func SongButton(_ sender: Any) {
        
        avPlayer?.play()
    }
    
    
    
    /*
    // MARK: - Navigation

     8 14:27:16.043818+0200 Lapp[7237:193868] [HardwareKeyboard] -[UIApplication getKeyboardDevicePropertiesForSenderID:shouldUpdate:usingSyntheticEvent:], failed to fetch device property for senderID (778835616971358211) use primary keyboard info instead.
     2022-04-28 14:27:16.046429+0200 Lapp[7237:193868] [HardwareKeyboard] -[UIApplication getKeyboardDevicePropertiesForSenderID:shouldUpdate:usingSyntheticEvent:], failed to fetch device property for senderID (778835616971358211) use primary keyboard info instead.
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
