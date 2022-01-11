//
//  VideoListViewController.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import UIKit
import Combine

class VideoListViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var videoListTableView: UITableView!

    // Creation of view model
    lazy var viewModel: VideoListViewModel = {
        let vm = VideoListViewModel(dataManager: NetworkManager<VideoListViewModel.dataType>())
        return vm
    }()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform.scaledBy(x: 3, y: 3)
        view.color = .red.withAlphaComponent(0.7)
        view.startAnimating()
        return view
    }()

    lazy var errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVideoListTableView()
        bindTableViewWithData()
        viewModel.getVideos()
        self.title = "Video List"
    }

    // Start of Video List Table View Configuration
    func configureVideoListTableView() {
        videoListTableView.delegate = self
        videoListTableView.dataSource = self
        videoListTableView.register(UINib(nibName: "VideoListTableViewCell", bundle: nil), forCellReuseIdentifier: CellIndentifierConstants.shared.videoListTableViewCellIdentifier)
        videoListTableView.rowHeight = UIScreen.main.bounds.height * 0.2
        videoListTableView.backgroundColor = .clear
    }
    // End of Video List Table View Configuration


    // Start of loading indicator's functions
    func createLoadingIndicator() {
        view.addSubview(loadingIndicator)
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            loadingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            loadingIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            loadingIndicator.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor ,constant: -30),

            errorLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    func removeLoadingIndicator() {
        loadingIndicator.removeFromSuperview()
        errorLabel.removeFromSuperview()
    }
    // End of loading indicator's functions

    // Bind the video list table view with data coming from view model
    func bindTableViewWithData() {
        viewModel.$shouldUpdateUI.sink { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.errorMessage == nil {
                DispatchQueue.main.async {
                    self.removeLoadingIndicator()
                    self.videoListTableView.reloadData()
                }
            }
            else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.errorLabel.text = self.viewModel.errorMessage
                    self.createLoadingIndicator()
                }
            }
        }.store(in: &cancellables)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToVideoPlayerVC" {
            let destinationVC = segue.destination as? VideoPlayerViewController
            let selectedVideo = sender as! Video
            let viewModelForVideoPlayer = VideoPlayerViewModel(selectedVideo: selectedVideo)
            destinationVC?.viewModel = viewModelForVideoPlayer
        }
    }
}
