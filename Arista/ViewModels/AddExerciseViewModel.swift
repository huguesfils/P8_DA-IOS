//
//  AddExerciseViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class AddExerciseViewModel: ObservableObject {
    @Published var category: String = ""
    @Published var startTime: String = ""
    @Published var duration: String = ""
    @Published var intensity: String = ""
    @Published var errorMessage: String? = nil

    private let repository: ExerciseRepository

    init(repository: ExerciseRepository) {
        self.repository = repository
    }

    func addExercise() -> Bool {
        guard let durationInt = Int32(duration), !category.isEmpty, !intensity.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs correctement."
            return false
        }
        do {
            try repository.addExercise(type: category, duration: durationInt, intensity: intensity, date: Date())
            return true
        } catch {
            errorMessage = "Erreur lors de l'ajout de l'exercice : \(error.localizedDescription)"
            return false
        }
    }
}
