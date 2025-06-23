import Foundation
import CoreData

protocol ExerciseRepositoryInterface {
    func fetchExercises() throws -> [ExerciseEntity]
    func addExercise(type: String, duration: Int32, intensity: Int32, date: Date) throws
}

struct ExerciseRepository: ExerciseRepositoryInterface {
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func fetchExercises() throws -> [ExerciseEntity] {
        let request = ExerciseEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return try viewContext.fetch(request)
    }
    
    func addExercise(type: String, duration: Int32, intensity: Int32, date: Date) throws {
        let exercise = ExerciseEntity(context: viewContext)
        exercise.id = UUID()
        exercise.type = type
        exercise.duration = duration
        exercise.intensity = intensity
        exercise.date = date
        try viewContext.save()
    }
}
