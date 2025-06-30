import Foundation
import CoreData

final class CoreDataMock {
    static func makeInMemoryContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "Arista")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        return container
    }
}
