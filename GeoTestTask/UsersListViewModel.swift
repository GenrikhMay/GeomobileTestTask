//
//  UsersListViewModel.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import RxCocoa
import RxSwift

class UsersListViewModel {
    public var users: PublishSubject<[User]> = PublishSubject()
    private let userService: UsersNetworkServiceProtocol = UsersNetworkService()
    private let disposeBag = DisposeBag()

    func getUsers() {
        userService.getUsers()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { result in
                    self.users.onNext(result.data)
                }
            )
            .disposed(by: disposeBag)
    }

}
