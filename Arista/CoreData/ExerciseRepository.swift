//
//  ExerciseRepository.swift
//  Arista
//
//  Created by Hugues Fils Caparos on 26/05/2025.
//

import Foundation
import CoreData

struct ExerciseRepository {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getExercises() throws -> [Exercise] {
        let request = Exercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Exercise>(\.date, order: .reverse))]
        return try viewContext.fetch(request)
    }
    
    func addExercise(type: String, duration: Int32, intensity: String, date: Date) throws {
        let exercise = Exercise(context: viewContext)
        exercise.type = type
        exercise.duration = duration
        exercise.intensity = intensity
        exercise.date = date
        try viewContext.save()
    }
}
