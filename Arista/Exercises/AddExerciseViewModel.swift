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
    var categories = ["Football", "Natation", "Running", "Marche", "Cyclisme", "Autre"]
    var selectedTime: Date = Date()
    var intensityDouble: Double = 0
    
    private let repository: ExerciseRepositoryInterface
    
    init(repository: ExerciseRepositoryInterface = ExerciseRepository()) {
        self.repository = repository
        reset()
    }
    
    private func reset() {
        if category.isEmpty {
            category = categories.first ?? "Autre"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        startTime = formatter.string(from: selectedTime)
        if intensity.isEmpty {
            intensity = String(Int(intensityDouble))
        } else if let intValue = Int(intensity) {
            intensityDouble = Double(intValue)
        }
    }
    
    var isFormValid: Bool {
        !category.isEmpty && !duration.isEmpty && !intensity.isEmpty && Int(duration) != nil && Int(intensity) != nil
    }
    
    func addExercise() -> Bool {
        guard let durationInt = Int32(duration),
              let intensityInt = Int32(intensity),
              !category.isEmpty, !intensity.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs correctement."
            return false
        }
        guard intensityInt >= 0 && intensityInt <= 10 else {
            errorMessage = "L'intensité doit être comprise entre 0 et 10."
            return false
        }
        do {
            let calendar = Calendar.current
            let now = Date()
            let selectedComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: now)
            dateComponents.hour = selectedComponents.hour
            dateComponents.minute = selectedComponents.minute
            let finalDate = calendar.date(from: dateComponents) ?? Date()
            try repository.addExercise(type: category, duration: durationInt, intensity: intensityInt, date: finalDate)
            return true
        } catch {
            errorMessage = "Erreur lors de l'ajout de l'exercice : \(error.localizedDescription)"
            return false
        }
    }
}
