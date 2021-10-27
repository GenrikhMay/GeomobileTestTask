//
//  UserModel.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import CoreData
import RxCoreData
import Foundation

struct User: Codable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String?
    var avatar: String?

    var fullName: String {
        firstName + (lastName ?? "")
    }

    internal init(id: Int, email: String, firstName: String, lastName: String? = nil, avatar: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }

    init (from persUser: PersistableUser) {
        self.id = persUser.id
        self.email = persUser.email
        self.firstName = persUser.firstName
        self.lastName = persUser.lastName
        self.avatar = persUser.avatar
    }
}
