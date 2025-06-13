//
//  UserRepository.swift
//  Arista
//
//  Created by Hugues Fils Caparos on 26/05/2025.
//

import Foundation
import CoreData

struct UserRepository {
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
