//
//  CoreDataService.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import CoreData
import Foundation

class CoreDataStack {
    private init() {}

    static let shared = CoreDataStack()

    lazy var applicationDocumentsDirectory: URL? = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last
    }()

    lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: "GeoTestTask", withExtension: "momd")
        else {
            return nil
        }
        return NSManagedObjectModel(contentsOf: modelURL)
    }()

    func getPersistentStoreCoordinator() -> Result<NSPersistentStoreCoordinator?, CoreDataError> {
        guard let directory = self.applicationDocumentsDirectory,
              let managedObjectModel = self.managedObjectModel
        else {
            return .failure(.directoryFailure)
        }

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = directory.appendingPathComponent("RxCoreData.sqlite")

        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            return .failure(.loadDataFailure)
        }

        return .success(coordinator)
    }

    lazy var managedObjectContext: NSManagedObjectContext? = {
        switch self.getPersistentStoreCoordinator() {
        case .success(let coordinator):
            var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = coordinator
            return managedObjectContext
        case .failure(let error):
            return nil
        }
    }()
}
