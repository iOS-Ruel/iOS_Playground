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
    
    private var playerViewDelegate: PlayerViewDelegate? {
        return playerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchTouch(_ sender: Any) {
        Task { @MainActor in
            guard let urlString = urlTextField.text, !urlString.isEmpty, 
                    let url = URL(string: urlString) else {
                showAlert(message: "Please enter a valid URL")
                return
            }
            await playerViewDelegate?.configurePlayer(with: url)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

