//
//  VideoPlayerView.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 7.01.2022.
//

import AVFoundation
import UIKit

@IBDesignable

class VideoPlayerView: UIView {

    @IBAction private func timeSliderValueChanged(_ sender: Any) {
        guard let duration = player?.currentItem?.duration else { return }
        let value = Float64(timeSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime)
    }
    
    @IBOutlet private weak var timeSlider: UISlider!
    @IBOutlet private weak var popupAnimationView: PopUpAnimation!
    weak var delegate: VideoPlayerDelegate?
    private var timeObserver: Any?

    @IBAction private func pauseButtonClicked(_ sender: Any) {
        showAnimationView(isPause: true)
        self.delegate?.shouldPauseTheVideo()
    }
    @IBAction private func playButtonClicked(_ sender: Any) {
        showAnimationView(isPause: false)
        self.delegate?.shouldStartTheVideo()
    }

    private func showAnimationView(isPause: Bool) {
        if let player = player {
            if !(player.isPlaying) && !isPause {
                self.popupAnimationView.isHidden = false
                popupAnimationView.iconImageView.image = UIImage(systemName: "play")
            }
            else if (player.isPlaying) && isPause {
                self.popupAnimationView.isHidden = false
                popupAnimationView.iconImageView.image = UIImage(systemName: "pause")
            }
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.allowUserInteraction]) { [weak self] in
            guard let self = self else { return }
            self.popupAnimationView.transform = CGAffineTransform(scaleX: 2, y: 2)
        } completion: { _ in
            self.popupAnimationView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.popupAnimationView.isHidden = true
        }
    }

    private func updateVideoPlayerSlider() {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        timeSlider.value = Float(currentTimeInSeconds)
        if let currentItem = player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return
            }
            let currentTime = currentItem.currentTime()
            timeSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
        }
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    private var playerItemContext = 0

    private var playerItem: AVPlayerItem?

    private func setUpAsset(with url: URL, completion: ((_ asset: AVAsset) -> Void)?) {
        let asset = AVAsset(url: url)
        asset.loadValuesAsynchronously(forKeys: ["playable"]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: "playable", error: &error)
            switch status {
            case .loaded:
                completion?(asset)
            case .failed:
                self.delegate?.didFailedToLoad()
            case .cancelled:
                print(".cancelled")
            default:
                print("default")
            }
        }
    }

    private func setUpPlayerItem(with asset: AVAsset) {
        playerItem = AVPlayerItem(asset: asset)
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)

        DispatchQueue.main.async { [weak self] in
            self?.player = AVPlayer(playerItem: self?.playerItem!)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            switch status {
            case .readyToPlay:
                self.delegate?.shouldStartTheVideo()
            case .failed:
                self.delegate?.didFailedToLoad()
            case .unknown:
                print(".unknown")
            @unknown default:
                print("@unknown default")
            }
        }

        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] elapsedTime in
            self?.updateVideoPlayerSlider()
        })
    }

    var contentView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadViewFromNib()
        contentView!.frame = bounds
        contentView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView!)
        self.bringSubviewToFront(popupAnimationView)

    }

    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

    func play(with url: URL) {
        setUpAsset(with: url) { [weak self] (asset: AVAsset) in
            self?.setUpPlayerItem(with: asset)
        }
    }

    deinit {
        self.delegate?.shouldDestoryVideo()
        playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
    }
}
