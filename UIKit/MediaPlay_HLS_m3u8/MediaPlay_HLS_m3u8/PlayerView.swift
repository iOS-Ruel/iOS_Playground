//
//  PlayerView.swift
//  MediaPlay_HLS_m3u8
//
//  Created by Chung Wussup
//

import Foundation
import AVKit

class PlayerView: UIView {
    
    private var playTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private var totalPlayTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private var playerSiderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private var playerPlaySiderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 2
        return view
    }()
    
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var currentTime: Double {
        return player?.currentItem?.currentTime().seconds ?? 0
    }
    
    var totalDurationTime: Double {
        return player?.currentItem?.duration.seconds ?? 0
    }
    
    var duration: CMTime {
        return player?.currentItem?.duration ?? CMTime(seconds: 1, preferredTimescale: 1)
    }
    
    var currentItem: AVPlayerItem? {
        return player?.currentItem
    }
    
    private var playerPlaySiderWidthConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlayerView()
    }
    
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    
    func setupPlayerView() {
        self.backgroundColor = .black
        [playerSiderView, playTimeLabel, totalPlayTimeLabel].forEach {
            addSubview($0)
        }
        
        playerSiderView.addSubview(playerPlaySiderView)
        
        playerPlaySiderWidthConstraint = playerPlaySiderView.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            playerSiderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            playerSiderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            playerSiderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            playerSiderView.heightAnchor.constraint(equalToConstant: 5),
            
            totalPlayTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            totalPlayTimeLabel.bottomAnchor.constraint(equalTo: playerSiderView.topAnchor, constant: -10),

            playTimeLabel.trailingAnchor.constraint(equalTo: totalPlayTimeLabel.leadingAnchor),
            playTimeLabel.bottomAnchor.constraint(equalTo: playerSiderView.topAnchor, constant: -10),
            playTimeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor,constant: 16),
            
            playerPlaySiderView.leadingAnchor.constraint(equalTo: playerSiderView.leadingAnchor),
            playerPlaySiderView.topAnchor.constraint(equalTo: playerSiderView.topAnchor),
            playerPlaySiderView.bottomAnchor.constraint(equalTo: playerSiderView.bottomAnchor),
            playerPlaySiderWidthConstraint
        ])
    }
    
    
    func updatePlayTimeLabel(with time: String) {
        playTimeLabel.text = time
    }
    
    func updateTotalPlayTimeLabel(with time: String) {
        totalPlayTimeLabel.text = time
    }
    
    func updateSlider(currentTime: Double, totalTime: Double) {
        guard !currentTime.isNaN, !totalTime.isNaN, totalTime > 0 else {
            playerPlaySiderWidthConstraint.constant = 0
            return
        }
        
        let progress = currentTime / totalTime
        playerPlaySiderWidthConstraint.constant = CGFloat(progress) * playerSiderView.frame.width
        layoutIfNeeded()
    }
}
