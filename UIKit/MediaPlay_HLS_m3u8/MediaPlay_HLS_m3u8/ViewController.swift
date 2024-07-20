//
//  ViewController.swift
//  MediaPlay_HLS_m3u8
//
//  Created by Chung Wussup 
//

import UIKit
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchTouch(_ sender: Any) {
        guard let urlString = urlTextField.text else {
            return
        }
        setupPlayer(urlString: urlString)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupPlayer(urlString: String) {
        if let url = URL(string: urlString) {
            let playerItem = AVPlayerItem(url: url)
            playerItem.preferredForwardBufferDuration = TimeInterval(1.0)
            playerView.player = AVPlayer(playerItem: playerItem)
        }
    }
    
    @IBAction func playButtonTouch(_ sender: Any) {
        playerView.player?.play()
    }
    
    @IBAction func stopButtonTouch(_ sender: Any) {
        playerView.player?.pause()
    }
    

}


