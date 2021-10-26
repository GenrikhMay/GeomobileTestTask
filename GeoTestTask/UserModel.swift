//
//  UserModel.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation

struct GetUsersNetworkResponse: Codable {
    var page: Int?
    var perPage: Int?
    var total: Int?
    var totalPage: Int?
    var data: [User]
}

struct User: Codable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String?
    var avatar: String

    var fullName: String {
        firstName + (lastName ?? "")
    }
}
