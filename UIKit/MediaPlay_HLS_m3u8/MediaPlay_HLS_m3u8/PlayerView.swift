//
//  PlayerView.swift
//  MediaPlay_HLS_m3u8
//
//  Created by Chung Wussup
//

import Foundation
import AVKit

class PlayerView: UIView {
    
    private let playTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private let totalPlayTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private let playerSliderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var playerPlaySliderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 2
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
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
        return AVPlayerLayer.self
    }
    
    private func setupPlayerView() {
        backgroundColor = .black
        [playerSliderView, playTimeLabel, totalPlayTimeLabel].forEach { addSubview($0) }
        
        playerSliderView.addSubview(playerPlaySliderView)
        
        playerPlaySiderWidthConstraint = playerPlaySliderView.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            playerSliderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            playerSliderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            playerSliderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            playerSliderView.heightAnchor.constraint(equalToConstant: 5),
            
            totalPlayTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            totalPlayTimeLabel.bottomAnchor.constraint(equalTo: playerSliderView.topAnchor, constant: -10),
            
            playTimeLabel.trailingAnchor.constraint(equalTo: totalPlayTimeLabel.leadingAnchor, constant: -8),
            playTimeLabel.bottomAnchor.constraint(equalTo: playerSliderView.topAnchor, constant: -10),
            playTimeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor,constant: 16),
            
            playerPlaySliderView.leadingAnchor.constraint(equalTo: playerSliderView.leadingAnchor),
            playerPlaySliderView.topAnchor.constraint(equalTo: playerSliderView.topAnchor),
            playerPlaySliderView.bottomAnchor.constraint(equalTo: playerSliderView.bottomAnchor),
            playerPlaySiderWidthConstraint
        ])
    }
    
    func updatePlayTimeLabel(with time: String) {
        playTimeLabel.text = time
        layoutIfNeeded()
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
        playerPlaySiderWidthConstraint.constant = CGFloat(progress) * playerSliderView.frame.width
        layoutIfNeeded()
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: playerPlaySliderView)
        let totalWidth = playerSliderView.frame.width
        let progress = min(max(location.x / totalWidth, 0), 1)
        
        switch gesture.state {
        case .began, .changed :
            updateSlider(currentTime: Double(progress) * totalDurationTime, totalTime: totalDurationTime)
        case .ended:
            let seekTime = CMTime(seconds: Double(progress) * totalDurationTime, preferredTimescale: 600)
            player?.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
        default:
            break
        }
    }
}
