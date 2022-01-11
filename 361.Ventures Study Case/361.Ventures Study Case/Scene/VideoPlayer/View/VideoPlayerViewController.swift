//
//  VideoPlayerViewController.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import UIKit

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerView: VideoPlayerView!
    var viewModel: VideoPlayerViewModel!

    lazy private var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .red
        view.startAnimating()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        createLoadingIndicator()
        title = "\(viewModel.selectedVideo?.title ?? "None")"
        videoPlayerView.delegate = self
        videoPlayerView.play(with: viewModel.getFileURL())
    }

    func createLoadingIndicator() {
        self.videoPlayerView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor , constant: 20),
            loadingIndicator.trailingAnchor.constraint(equalTo: videoPlayerView.trailingAnchor , constant: -20),
            loadingIndicator.bottomAnchor.constraint(equalTo: videoPlayerView.bottomAnchor , constant: -20),
            loadingIndicator.topAnchor.constraint(equalTo: videoPlayerView.topAnchor , constant: 20),
        ])
    }
    
    func destroyLoadingIndicator() {
        loadingIndicator.removeFromSuperview()
    }
}
