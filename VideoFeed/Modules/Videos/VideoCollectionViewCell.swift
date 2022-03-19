//
//  VideoCollectionViewCell.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 20/09/21.
//

import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    private var player: AVPlayer?
    private var playerView: AVPlayerLayer?
    private var urlStr: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with url: String) {
        self.urlStr = url
    }
    func startPlaying() {
        guard let urlStr = self.urlStr,
              let url = URL(string: urlStr) else { return }
        player = AVPlayer(url: url)
        playerView = AVPlayerLayer(player: player)
        playerView!.player = player
        playerView!.frame = contentView.bounds
        playerView!.videoGravity = .resizeAspectFill
        player?.volume = 0
        contentView.layer.addSublayer(playerView!)
        player?.play()
    }
    func stopPlaying() {
        player?.replaceCurrentItem(with: nil)
        playerView?.removeFromSuperlayer()
        playerView = nil
        player = nil
    }
}
