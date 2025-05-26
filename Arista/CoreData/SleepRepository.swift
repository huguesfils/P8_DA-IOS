//
//  SleepRepository.swift
//  Arista
//
//  Created by Hugues Fils Caparos on 26/05/2025.
//

import Foundation
import CoreData

struct SleepRepository {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getSleepSessions() throws -> [Sleep] {
        let request = Sleep.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Sleep>(\.startTime, order: .reverse))]
        return try viewContext.fetch(request)
    }
}
