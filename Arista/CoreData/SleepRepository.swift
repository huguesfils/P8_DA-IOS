import Foundation
import CoreData

protocol SleepRepositoryInterface {
    func getSleepSessions() throws -> [SleepEntity]
}

struct SleepRepository: SleepRepositoryInterface {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getSleepSessions() throws -> [SleepEntity] {
        let request = SleepEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<SleepEntity>(\.startTime, order: .reverse))]
        return try viewContext.fetch(request)
    }
}
