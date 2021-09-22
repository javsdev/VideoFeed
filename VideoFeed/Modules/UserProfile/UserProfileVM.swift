//
//  ProfileViewModel.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import Foundation
import RxSwift

class UserProfileVM {
    private let defaultImageName = "user_photo"
    private let usersService = MockUsersService.shared
    private let fetchUserSubject = PublishSubject<Void>()
    var fetchUserObs: Observable<Void> {
        fetchUserSubject.asObservable()
    }
    private var user: User?
    var usernameText: String {
        user?.userName ?? ""
    }
    var videosText: String {
        "\(user?.videos ?? 0) Videos"
    }
    var followingText: String {
        "\(user?.following ?? 0)\nFollowing"
    }
    var fansText: String {
        "\(user?.fans ?? 0)\nFans"
    }
    var heartsText: String {
        "\(user?.hearts ?? 0)\nHearts"
    }
    var editProfileText: String {
        "Edit Profile"
    }
    var bioText: String {
        user?.userBio ?? ""
    }
    var viewTitle: String {
        user?.title ?? ""
    }
    var profileImage: UIImage? {
        if let imageName = user?.profileImage,
           let imagePath = Bundle.main.path(forResource: imageName, ofType: "png") {
            return UIImage(contentsOfFile: imagePath)
        } else {
            return UIImage(named: defaultImageName)
        }
    }
    func fetchUser() {
        usersService.fetchUser(byUsername: "@user_test") { [weak self] result in
            switch result {
            case .success(let user):
                self?.handleUserFetched(user: user)
            case.failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    func handleUserFetched(user: User) {
        self.user = user
        fetchUserSubject.onNext(())
    }
    func handleError(error: Error) {
        print("Error with usersService.fetchUser \(error)")
    }
}
