//
//  CoreDataService.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import CoreData
import RxSwift
import RxDataSources
import RxCoreData

protocol UsersPersistentStorageServiceProtocol: AnyObject {
    func saveData(items: [User])

    func fetchDataFromStorage() -> Observable <[User]>
}

final class UsersPersistentStorageService: UsersPersistentStorageServiceProtocol {
    private let disposeBag = DisposeBag()

    private var managedObjectContext: NSManagedObjectContext? {
        return CoreDataStack.shared.managedObjectContext
    }

    func saveData(items: [User]) {
        items.forEach({
            try? self.managedObjectContext?.rx.update(PersistableUser(from: $0))
        })
    }

    func fetchDataFromStorage() -> Observable<[User]> {
        guard let context = managedObjectContext
        else {
            return Observable.just([])
        }
        return context.rx.entities(PersistableUser.self)
            .map { users in
                users.map { User(from: $0) }
            }
    }
}
