//
//  DBService.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 29..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import CoreData

final class DBService {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Andrew")
        let descriptions = NSPersistentStoreDescription()
        descriptions.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [descriptions]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    var privateContext: NSManagedObjectContext? {
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = self.context
        return privateMOC
    }
    
    func save(_ privateContext: NSManagedObjectContext) {
        do {
            try privateContext.save()
            privateContext.performAndWait {
                do { try self.context.save() }
                catch { fatalError("Failure to save context: \(error)") }
            }
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
