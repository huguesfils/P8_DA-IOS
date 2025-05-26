//
//  SleepHistoryViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class SleepHistoryViewModel: ObservableObject {
    @Published var sleepSessions = [Sleep]()
    @Published var errorMessage: String?
    
    private let repository: SleepRepository
    
    init(repository: SleepRepository) {
        self.repository = repository
        fetchSleepSessions()
    }
    
    func fetchSleepSessions() {
        do {
            sleepSessions = try repository.getSleepSessions()
        } catch {
            errorMessage = "Erreur lors du chargement des données : \(error.localizedDescription)"
        }
    }
}
