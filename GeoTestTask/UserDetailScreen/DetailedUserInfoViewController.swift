//
//  DetailedUserInfoViewCOntroller.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class DetailedUserInfoViewController: UIViewController {
    private let userImage = UIImageView()
    private let userNameLabel = UILabel()
    private let emailLabel = UILabel()

    let viewModel: UserDetailsViewModel

    private let disposeBag = DisposeBag()

    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        viewModel.userName.bind(to: userNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.userEmail.bind(to: emailLabel.rx.text).disposed(by: disposeBag)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.avatarURL.subscribe(onNext: { newURL in
            if let urlString = newURL, let url = URL(string: urlString) {
                self.userImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
            }
        })
        .disposed(by: disposeBag)
    }

    func configureView() {
        view.backgroundColor = UIColor(ciColor: .white)
        view.addSubview(userNameLabel)
        view.addSubview(userImage)
        view.addSubview(emailLabel)

        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImage.bottomAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: -24).isActive = true
        userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true
        userImage.image = UIImage(systemName: "person")
        userImage.layer.cornerRadius = 16
        userImage.clipsToBounds = true

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -16).isActive = true

        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -32).isActive = true
    }
}
