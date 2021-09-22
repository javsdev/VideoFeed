//
//  User.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 21/09/21.
//

import Foundation

struct User: Codable, Equatable {
    var userName: String
    var title: String
    var profileImage: String
    var videos: Int
    var following: Int
    var fans: Int
    var hearts: Int
    var userBio: String
    public init(userName: String,
                title: String,
                profileImage: String,
                videos: Int,
                following: Int,
                fans: Int,
                hearts: Int,
                userBio: String) {
        self.userName = userName
        self.title = title
        self.profileImage = profileImage
        self.videos = videos
        self.following = following
        self.fans = fans
        self.hearts = hearts
        self.userBio = userBio
    }
    private enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case title = "user_title"
        case profileImage = "user_local_image"
        case videos = "user_videos"
        case following = "user_following"
        case fans = "user_fans"
        case hearts = "user_hearts"
        case userBio = "user_bio"
    }
}
