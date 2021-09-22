//
//  VideosViewModel.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import Foundation
import RxSwift

class VideoFeedVM {
    weak var coordinatorDelegate: VideoFeedCoordinatorVMDelegate?
    let videoFeedService = MockVideoFeedService.shared
    private var videos: [VideoInfo]?
    private let fetchVideosSubject = PublishSubject<Void>()
    var fetchVideosObs: Observable<Void> {
        fetchVideosSubject.asObservable()
    }
    var urlVideos: [String] {
        if let videos = self.videos {
            return videos.map { $0.path }
        } else {
            return []
        }
    }
    func fetchVideos() {
        videoFeedService.fetchVideoFeed { [weak self] result in
            switch result {
            case .success(let videos):
                self?.handleVideosFetched(videos: videos)
            case.failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    func handleVideosFetched(videos: [VideoInfo]) {
        self.videos = videos
        fetchVideosSubject.onNext(())
    }
    func handleError(error: Error) {
        print("Error with videoFeedService.fetchVideos \(error)")
    }
}
