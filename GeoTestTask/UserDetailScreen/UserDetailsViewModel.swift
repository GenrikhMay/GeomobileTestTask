//
//  UserDetailsViewModel.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 27.10.2021.
//

import Foundation
import RxSwift

final class UserDetailsViewModel {
    public var userName: BehaviorSubject<String>
    public var userEmail: BehaviorSubject<String>
    public var avatarURL: BehaviorSubject<String?>

    init(with user: User) {
        userName = BehaviorSubject(value: user.fullName)
        userEmail = BehaviorSubject(value: user.email)
        avatarURL = BehaviorSubject(value: user.avatar)
    }
}
