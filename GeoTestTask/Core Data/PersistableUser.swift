//
//  PersistableUser.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 27.10.2021.
//

import CoreData
import Foundation
import RxCoreData

struct PersistableUser: Persistable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String?
    var avatar: String?

    init(from user: User) {
        self.id = user.id
        self.email = user.email
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.avatar = user.avatar
    }

    var identity: String {
        id.description
    }

    typealias T = NSManagedObject

    static var entityName: String {
        return "UserEntity"
    }

    static var primaryAttributeName: String {
        return "id"
    }

    init(entity: T) {
        id = entity.value(forKey: "id") as! Int
        email = entity.value(forKey: "email") as? String ?? ""
        firstName = entity.value(forKey: "firstName") as? String ?? ""
        lastName = entity.value(forKey: "lastName") as? String
        avatar = entity.value(forKey: "avatar") as? String
    }

    func update(_ entity: T) {
        entity.setValue(Int32(id), forKey: "id")
        entity.setValue(email, forKey: "email")
        entity.setValue(firstName, forKey: "firstName")
        entity.setValue(lastName, forKey: "lastName")
        entity.setValue(avatar, forKey: "avatar")

        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}
