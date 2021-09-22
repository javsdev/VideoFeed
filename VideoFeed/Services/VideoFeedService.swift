//
//  VideoFeedService.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 21/09/21.
//

import Foundation

protocol VideoFeedService {
    func fetchVideoFeed(completion: (Result<[VideoInfo], ServiceError>) -> Void)
}

class MockVideoFeedService: VideoFeedService {
    private let jsonFilename = "videos"
    static let shared = MockVideoFeedService()
    func fetchVideoFeed(completion: (Result<[VideoInfo], ServiceError>) -> Void) {
        guard let bundlePath = Bundle.main.path(forResource: jsonFilename,
                                                ofType: "json"),
              let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
            return completion(.failure(.jsonLoadingError))
        }
        do {
            let videos = try JSONDecoder().decode([VideoInfo].self, from: jsonData)
            completion(.success(videos))
        } catch {
            completion(.failure(.jsonParsingError))
        }
    }
}
