//
//  UserCellView.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import UIKit
import Kingfisher

class UserCellView: UITableViewCell {
    private let userImage = UIImageView()
    private let userNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
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

    func update(name: String, imageURL: String?) {
        userNameLabel.text = name
        if let urlString = imageURL, let url = URL(string: urlString) {
            userImage.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
        }
    }
}
