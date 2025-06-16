import Foundation
import CoreData

struct Exercise: Identifiable {
    let id: UUID
    let type: String
    let duration: Int32
    let intensity: String
    let date: Date
    
    init?(entity: ExerciseEntity) {
        guard let id = entity.id,
              let type = entity.type,
              let date = entity.date else {
            return nil
        }
        self.id = id
        self.type = type
        self.duration = entity.duration
        self.intensity = String(entity.intensity)
        self.date = date
    }
}

@MainActor
@Observable
final class ExerciseListViewModel {
    var exercises = [Exercise]()
    var errorMessage: String?
    
    private let repository: ExerciseRepository
    
    init(repository: ExerciseRepository = ExerciseRepository()) {
        self.repository = repository
        fetchExercises()
    }

    func fetchExercises() {
        do {
            let coreDataExercises = try repository.fetchExercises()
            exercises = coreDataExercises.compactMap { Exercise(entity: $0) }
        } catch {
            errorMessage = "Error loading data: \(error.localizedDescription)"
        }
    }
}
