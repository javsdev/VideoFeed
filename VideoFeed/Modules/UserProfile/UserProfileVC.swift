//
//  ProfileView.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileVC: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var videosLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var heartsLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    var viewModel: UserProfileVM?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureViewModel()
        fetchData()
    }
    private func configureViews() {
        let imageCornerRadius = profileImage.frame.width / 2
        profileImage.layer.cornerRadius = imageCornerRadius
    }
    private func configureViewModel() {
        viewModel?.fetchUserObs
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.updateViews()
            })
            .disposed(by: disposeBag)
    }
    private func fetchData() {
        viewModel?.fetchUser()
    }
    private func updateViews() {
        navigationItem.title = viewModel?.viewTitle
        profileImage.image = viewModel?.profileImage
        usernameLabel.text = viewModel?.usernameText
        videosLabel.text = viewModel?.videosText
        followingLabel.text = viewModel?.followingText
        fansLabel.text = viewModel?.fansText
        heartsLabel.text = viewModel?.heartsText
        bioTextView.text = viewModel?.bioText
        editProfileButton.setTitle(viewModel?.editProfileText, for: .normal)
    }
}

// MARK: - Creating instances

extension UserProfileVC {
    static func create() -> UserProfileVC {
        return UserProfileVC(nibName: "ProfileView", bundle: nil)
    }
}
