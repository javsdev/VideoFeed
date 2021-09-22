//
//  VideosView.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import UIKit
import AVKit
import RxSwift

class VideoFeedVC: UIViewController {
    private let cellName = "VideoCell"
    private let disposeBag = DisposeBag()
    private var collectionView: UICollectionView!
    var viewModel: VideoFeedVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewModel()
        fetchData()
    }
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: cellName)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    private func configureViewModel() {
        viewModel?.fetchVideosObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    private func fetchData() {
        viewModel?.fetchVideos()
    }
}

// MARK: - Creating instances

extension VideoFeedVC {
    static func create() -> VideoFeedVC {
        return VideoFeedVC(nibName: "VideosView", bundle: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension VideoFeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.urlVideos.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellName,
                for: indexPath) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let url = viewModel?.urlVideos[indexPath.row],
              let components = URLComponents(string: url) else {
            return UICollectionViewCell()
        }
        var httpComponents = components
        httpComponents.scheme = "http"
        guard let urlStr = httpComponents.string else {
            return UICollectionViewCell()
        }
        cell.configure(with: urlStr)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VideoFeedVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? VideoCollectionViewCell {
            cell.stopPlaying()
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? VideoCollectionViewCell {
            cell.startPlaying()
        }
    }
}
