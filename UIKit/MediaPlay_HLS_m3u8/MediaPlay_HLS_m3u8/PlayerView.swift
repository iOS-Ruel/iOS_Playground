//
//  PlayerView.swift
//  MediaPlay_HLS_m3u8
//
//  Created by Chung Wussup
//

import Foundation
import AVKit

protocol PlayerViewDelegate: AnyObject {
    func configurePlayer(with url: URL) async
}

class PlayerView: UIView, PlayerViewDelegate {
    
    private lazy var controllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleControlButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
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
    
    private let player = AVPlayer()
    private var timeObserver: Any?
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var currentTime: Double {
        return player.currentItem?.currentTime().seconds ?? 0
    }
    
    var totalDurationTime: Double {
        return player.currentItem?.duration.seconds ?? 0
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
        [playerSliderView, playTimeLabel, totalPlayTimeLabel, controllButton].forEach { addSubview($0) }
        
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
            playTimeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 16),
            
            playerPlaySliderView.leadingAnchor.constraint(equalTo: playerSliderView.leadingAnchor),
            playerPlaySliderView.topAnchor.constraint(equalTo: playerSliderView.topAnchor),
            playerPlaySliderView.bottomAnchor.constraint(equalTo: playerSliderView.bottomAnchor),
            playerPlaySiderWidthConstraint,
            
            controllButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            controllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPlayerView))
        self.addGestureRecognizer(singleTapGesture)
        
        let leftDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLeftDoubleTap))
        leftDoubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(leftDoubleTapGesture)
        
        let rightDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRightDoubleTap))
        rightDoubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(rightDoubleTapGesture)
        
        singleTapGesture.require(toFail: leftDoubleTapGesture)
        singleTapGesture.require(toFail: rightDoubleTapGesture)
        
        playerLayer.player = player
        addPeriodicTimeObserver()
        
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
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
        case .began, .changed:
            updateSlider(currentTime: Double(progress) * totalDurationTime, totalTime: totalDurationTime)
        case .ended:
            let seekTime = CMTime(seconds: Double(progress) * totalDurationTime, preferredTimescale: 600)
            player.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
        default:
            break
        }
    }
    
    @objc private func didTapPlayerView(_ gesture: UITapGestureRecognizer) {
        controllButtonSetup()
    }
    
    private func controllButtonSetup() {
        controllButton.isHidden.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.controllButton.isHidden = true
        }
    }
    
    @objc private func handleControlButton() {
        
        if player.timeControlStatus == .paused {
            play()
        } else {
            pause()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.controllButton.isHidden = false
        }
        
    }
    
    @objc private func handleLeftDoubleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self)
        if tapLocation.x < self.bounds.width / 2 {
            seekBackward()
        }
    }
    
    @objc private func handleRightDoubleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self)
        if tapLocation.x > self.bounds.width / 2 {
            seekForward()
        }
    }
    
    private func seekBackward() {
        let newTime = max(currentTime - 10, 0)
        let seekTime = CMTime(seconds: newTime, preferredTimescale: 600)
        player.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    private func seekForward() {
        let newTime = min(currentTime + 10, totalDurationTime)
        let seekTime = CMTime(seconds: newTime, preferredTimescale: 600)
        player.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    private func addPeriodicTimeObserver() {
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 10), queue: .main) { [weak self] time in
            self?.updateCurrentTime(time: time)
        }
    }
    
    private func updateCurrentTime(time: CMTime) {
        let currentSeconds = Int(time.seconds)
        let totalSeconds = totalDurationTime
        
        let seconds = currentSeconds % 60
        let minutes = currentSeconds / 60
        
        let timeFormatString = String(format: "%01d:%02d", minutes, seconds)
        DispatchQueue.main.async {
            self.updatePlayTimeLabel(with: timeFormatString)
            self.updateSlider(currentTime: time.seconds, totalTime: totalSeconds)
        }
    }
    
    func configurePlayer(with url: URL) async {
        let playerItem = AVPlayerItem(url: url)
        playerItem.preferredForwardBufferDuration = TimeInterval(1.0)
        
        DispatchQueue.main.async {
            self.player.replaceCurrentItem(with: playerItem)
            self.controllButton.isHidden = false
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
                    self.updateTotalPlayTimeLabel(with: "/ \(totalTimeString)")
                }
            }
        } catch {
            
        }
    }
    
    func play() {
        player.play()
        controllButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func pause() {
        player.pause()
        controllButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func controllButtonHidden() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.controllButton.isHidden = false
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus" {
            DispatchQueue.main.async {
                if self.player.timeControlStatus == .playing {
                    self.controllButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                } else {
                    self.controllButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                }
            }
        }
    }
    
}
