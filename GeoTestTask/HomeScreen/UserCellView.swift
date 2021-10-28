//
//  UserCellView.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift

final class UserCellView: UITableViewCell {
    private let userImage = UIImageView()
    private let userNameLabel = UILabel()

    let viewModel: UserCellViewModel = UserCellViewModel()

    private let disposeBag = DisposeBag()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setData(user: User) {
        viewModel.userName.bind(to: userNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.userName.onNext(user.fullName)
        viewModel.userAvatar.subscribe(onNext: { newURL in
            if let urlString = user.avatar, let url = URL(string: urlString) {
                self.userImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
            }
        })
        .disposed(by: disposeBag)
        viewModel.userAvatar.onNext(user.avatar)
    }

    func setup() {
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userImage)

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16).isActive = true
        userNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8).isActive = true

        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor).isActive = true
        userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true

        userImage.image = UIImage(systemName: "person")
        userImage.layer.cornerRadius = 8
        userImage.clipsToBounds = true

        contentView.addSubview(userImage)
        contentView.addSubview(userNameLabel)
    }
}
