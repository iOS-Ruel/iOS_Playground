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
        Task {
            await setupPlayer(urlString: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8")
        }
    }
    
    func setupPlayerView() {
        playerView.player = player
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 10), queue: DispatchQueue.main) { [weak self] time in
            self?.updateCurrentTime(time: time)
        }
    }
    
    @IBAction func searchTouch(_ sender: Any) {
        Task { @MainActor in
            guard let urlString = urlTextField.text else {
                return
            }
            await setupPlayer(urlString: urlString)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupPlayer(urlString: String) async {
        if let url = URL(string: urlString) {
            let playerItem = AVPlayerItem(url: url)
            playerItem.preferredForwardBufferDuration = TimeInterval(1.0)
            player.replaceCurrentItem(with: playerItem)
            
            // 전체 시간을 설정
            let assetDuration = try? await playerItem.asset.load(.duration)
            let totalSeconds = CMTimeGetSeconds(assetDuration ?? CMTime())
            
            if !totalSeconds.isNaN {
                let totalSecondsInt = Int(totalSeconds)
                let seconds = totalSecondsInt % 60
                let minutes = totalSecondsInt / 60
                let totalTimeString = String(format: "%01d:%02d", minutes, seconds)
                playerView.updateTotalPlayTimeLabel(with: " / \(totalTimeString)")
            }
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
        
        let timeFormatString  = String(format: "%01d:%02d", minutes, seconds)
        
        playerView.updatePlayTimeLabel(with: timeFormatString)
        playerView.updateSlider(currentTime: time.seconds, totalTime: totalSeconds)
    }
    
}


