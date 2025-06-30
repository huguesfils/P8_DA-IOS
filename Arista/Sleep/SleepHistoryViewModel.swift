import Foundation
import CoreData

@MainActor
@Observable
final class SleepHistoryViewModel {
    var sleepSessions = [Sleep]()
    var errorMessage: String?
    
    private let repository: SleepRepositoryInterface
    
    init(repository: SleepRepositoryInterface = SleepRepository()) {
        self.repository = repository
        fetchSleepSessions()
    }
    
    private func fetchSleepSessions() {
        do {
            let coreDataSessions = try repository.getSleepSessions()
            sleepSessions = coreDataSessions.compactMap { Sleep(entity: $0) }
        } catch {
            errorMessage = "Erreur lors du chargement des données : \(error.localizedDescription)"
        }
    }
}
