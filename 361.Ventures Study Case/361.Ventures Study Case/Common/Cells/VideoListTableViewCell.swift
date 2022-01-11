//
//  VideoListTableViewCell.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoThumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    func configureCell() {
        videoThumbnail.alpha = 0.6
        videoThumbnail.createRoundedCorner(by: 15)
        contentView.bringSubviewToFront(videoName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20))
    }
}
