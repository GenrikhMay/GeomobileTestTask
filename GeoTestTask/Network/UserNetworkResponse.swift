//
//  UserNetworkResponse.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 27.10.2021.
//

import Foundation

struct GetUsersNetworkResponse: Codable {
    var page: Int?
    var perPage: Int?
    var total: Int?
    var totalPage: Int?
    var data: [User]
}
