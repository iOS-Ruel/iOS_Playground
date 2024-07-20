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
        return label
    }()
    
    private var totalPlayTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var playerSider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupPlayerView() {
        self.backgroundColor = .black
        
        
    }
    
    
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
    
    var duration : CMTime {
        return player?.currentItem?.duration ?? CMTime(seconds: 1, preferredTimescale: 1)
    }
    var currentItem: AVPlayerItem? {
        return player?.currentItem
    }
    
}
