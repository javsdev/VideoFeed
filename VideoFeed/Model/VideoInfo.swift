//
//  File.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 21/09/21.
//

import Foundation

struct VideoInfo: Decodable {
    var description: String
    var path: String
    var comments: Int
    var likes: Int
    var userId: String
    var userName: String
    var userProfileImage: String
    public init(description: String,
                path: String,
                comments: Int,
                likes: Int,
                userId: String,
                userName: String,
                userProfileImage: String) {
        self.description = description
        self.path = path
        self.comments = comments
        self.likes = likes
        self.userId = userId
        self.userName = userName
        self.userProfileImage = userProfileImage
    }
    private enum CodingKeys: String, CodingKey {
        case description = "video_description"
        case path = "video_path"
        case comments = "video_number_comments"
        case likes = "video_number_likes"
        case userId = "user_id"
        case userName = "user_name"
        case userProfileImage = "user_image_path"
    }
}
