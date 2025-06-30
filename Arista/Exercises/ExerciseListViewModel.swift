import Foundation
import CoreData

@MainActor
@Observable
final class ExerciseListViewModel {
    var exercises = [Exercise]()
    var errorMessage: String?
    
    private let repository: ExerciseRepositoryInterface
    
    init(repository: ExerciseRepositoryInterface = ExerciseRepository()) {
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
