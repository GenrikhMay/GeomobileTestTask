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
    public var users: PublishSubject<[User]> = .init()
    private let userNetworkService: UsersNetworkServiceProtocol
    private let userLocalStorageService: UsersPersistentStorageServiceProtocol
    private let disposeBag = DisposeBag()

    init(
        userNetworkService: UsersNetworkServiceProtocol = UsersNetworkService(),
        userLocalStorageService: UsersPersistentStorageServiceProtocol = UsersPersistentStorageService()
    ) {
        self.userNetworkService = userNetworkService
        self.userLocalStorageService = userLocalStorageService
    }

    func getUsers() {
        userNetworkService.getUsers()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { result in
                    self.users.onNext(result.data)
                    self.userLocalStorageService.saveData(items: result.data)
                },
                onError: { error in
                    self.userLocalStorageService.fetchDataFromStorage()
                        .subscribe(
                            onNext: { result in
                                self.users.onNext(result)
                                self.users.onCompleted()
                            }
                        )
                        .disposed(by: self.disposeBag)
                }
            )
            .disposed(by: disposeBag)
    }

}
