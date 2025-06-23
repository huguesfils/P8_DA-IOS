import Foundation
import CoreData

protocol UserRepositoryInterface {
    func getUser() throws -> UserEntity?
}

struct UserRepository: UserRepositoryInterface {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getUser() throws -> UserEntity? {
        let request = UserEntity.fetchRequest()
        request.fetchLimit = 1
        return try viewContext.fetch(request).first
    }
}
