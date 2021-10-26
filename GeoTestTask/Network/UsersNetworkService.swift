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
    let networkService: NetworkServiceProtocol = NetworkService()

    func getUsers() -> Observable<GetUsersNetworkResponse> {
        let url = URL(string: Endpoints.getUser.rawValue)!
        let req = URLRequest(url: url)
        return networkService.fetch(request: req)
    }
}
