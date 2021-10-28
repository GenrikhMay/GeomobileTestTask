//
//  UserCellViewModel.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 28.10.2021.
//

import Foundation
import RxCocoa
import RxSwift

final class UserCellViewModel {
    public var userName: PublishSubject<String> = .init()
    public var userAvatar: PublishSubject<String?> = .init()
}
