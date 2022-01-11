//
//  VideoList+TableView.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//
import UIKit


extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIndentifierConstants.shared.videoListTableViewCellIdentifier, for: indexPath) as? VideoListTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.videos[indexPath.row]
        cell.videoName.text = data.title
        if let imageData = data.thumb {
            cell.videoThumbnail.networkImage(from: imageData, contentMode: .scaleAspectFill)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = viewModel.videos[indexPath.row]
        performSegue(withIdentifier: "navigateToVideoPlayerVC", sender: selectedVideo)
    }
}
