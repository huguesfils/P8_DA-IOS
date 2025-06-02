import Foundation
import CoreData

struct ExerciseViewData: Identifiable {
    let id: UUID
    let type: String
    let duration: Int32
    let intensity: String
    let date: Date
}

@MainActor
final class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [ExerciseViewData]()
    @Published var errorMessage: String?
    
    let repository: ExerciseRepository
    
    init(repository: ExerciseRepository) {
        self.repository = repository
        fetchExercises()
    }

    func fetchExercises() {
        do {
            let coreDataExercises = try repository.getExercises()
            exercises = coreDataExercises.map { exercise in
                ExerciseViewData(
                    id: exercise.id ?? UUID(),
                    type: exercise.type ?? "Inconnu",
                    duration: exercise.duration,
                    intensity: String(exercise.intensity),
                    date: exercise.date ?? Date()
                )
            }
        } catch {
            errorMessage = "Erreur lors du chargement des données : \(error.localizedDescription)"
        }
    }
}
