//
//  UsersNetworkService.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import RxSwift

protocol UsersNetworkServiceProtocol {
    func getUsers() -> Observable<GetUsersNetworkResponse>
}

class UsersNetworkService: UsersNetworkServiceProtocol {
    enum Endpoints: String {
        case getUser = "https://reqres.in/api/users"
    }

    let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func getUsers() -> Observable<GetUsersNetworkResponse> {
        let url = URL(string: Endpoints.getUser.rawValue)!
        let req = URLRequest(url: url)
        return networkService.fetch(request: req)
    }
}
