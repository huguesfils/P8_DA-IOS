import Foundation
import CoreData

struct Sleep: Identifiable {
    let id: UUID
    let startTime: Date
    let duration: Int32
    let quality: Int
    
    init?(entity: SleepEntity) {
        guard let id = entity.id, let startTime = entity.startTime else {
            return nil
        }
        self.id = id
        self.startTime = startTime
        self.duration = entity.duration
        self.quality = Int(entity.quality)
    }
}

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
