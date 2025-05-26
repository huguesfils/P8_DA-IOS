//
//  ExerciseListViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

import CoreData

class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [Exercise]()
    @Published var errorMessage: String?
    
    private let repository: ExerciseRepository
    
    init(repository: ExerciseRepository) {
        self.repository = repository
        fetchExercises()
    }

    private func fetchExercises() {
        do {
            exercises = try repository.getExercises()
        } catch {
            errorMessage = "Erreur lors du chargement des données : \(error.localizedDescription)"
        }
    }
}

