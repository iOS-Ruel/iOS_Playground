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
    
    var timeObserver: Any?
    let player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerView()
    }
    
    func setupPlayerView() {
        playerView.player = player
        
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 10), queue: .main) { [weak self] time in
            self?.updateCurrentTime(time: time)
        }
    }
    
    @IBAction func searchTouch(_ sender: Any) {
        Task { @MainActor in
            guard let urlString = urlTextField.text, !urlString.isEmpty else {
                showAlert(message: "Please enter a valid URL")
                return
            }
            await setupPlayer(urlString: urlString)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupPlayer(urlString: String) async {
        guard let url = URL(string: urlString) else {
            showAlert(message: "Invalid URL")
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        playerItem.preferredForwardBufferDuration = TimeInterval(1.0)
        
        DispatchQueue.main.async {
            self.player.replaceCurrentItem(with: playerItem)
        }
        
        do {
            let assetDuration = try await playerItem.asset.load(.duration)
            let totalSeconds = CMTimeGetSeconds(assetDuration)
            
            if !totalSeconds.isNaN {
                let totalSecondsInt = Int(totalSeconds)
                let seconds = totalSecondsInt % 60
                let minutes = totalSecondsInt / 60
                let totalTimeString = String(format: "%01d:%02d", minutes, seconds)
                DispatchQueue.main.async {
                    self.playerView.updateTotalPlayTimeLabel(with: "/ \(totalTimeString)")
                }
            }
        } catch {
            showAlert(message: "Failed to load media duration")
        }
    }
    
    @IBAction func playButtonTouch(_ sender: Any) {
        playerView.player?.play()
    }
    
    @IBAction func stopButtonTouch(_ sender: Any) {
        playerView.player?.pause()
    }
    
    func updateCurrentTime(time: CMTime) {
        let currentSeconds = Int(time.seconds)
        let totalSeconds = playerView.totalDurationTime
        
        let seconds = currentSeconds % 60
        let minutes = currentSeconds / 60
        
        let timeFormatString = String(format: "%01d:%02d", minutes, seconds)
        DispatchQueue.main.async {
            self.playerView.updatePlayTimeLabel(with: timeFormatString)
            
            self.playerView.updateSlider(currentTime: time.seconds, totalTime: totalSeconds)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

