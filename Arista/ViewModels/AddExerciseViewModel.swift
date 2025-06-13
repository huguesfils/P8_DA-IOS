import Foundation
import CoreData

@MainActor
@Observable
final class AddExerciseViewModel {
    var category: String = ""
    var startTime: String = ""
    var duration: String = ""
    var intensity: String = ""
    var errorMessage: String? = nil
    
    private let repository: ExerciseRepository
    
    init(repository: ExerciseRepository) {
        self.repository = repository
    }
    
    func addExercise() -> Bool {
        guard let durationInt = Int32(duration),
              let intensityInt = Int32(intensity),
              !category.isEmpty, !intensity.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs correctement."
            return false
        }
        do {
            try repository.addExercise(type: category, duration: durationInt, intensity: intensityInt, date: Date())
            return true
        } catch {
            errorMessage = "Erreur lors de l'ajout de l'exercice : \(error.localizedDescription)"
            return false
        }
    }
}
