import Foundation
import CoreData

struct SleepViewData: Identifiable {
    let id: UUID
    let startTime: Date
    let duration: Int32
    let quality: Int
}

@MainActor
final class SleepHistoryViewModel: ObservableObject {
    @Published var sleepSessions = [SleepViewData]()
    @Published var errorMessage: String?
    
    private let repository: SleepRepository
    
    init(repository: SleepRepository) {
        self.repository = repository
        fetchSleepSessions()
    }
    
    private func fetchSleepSessions() {
        do {
            let coreDataSessions = try repository.getSleepSessions()
            sleepSessions = coreDataSessions.compactMap { session in
                guard let id = session.id, let startTime = session.startTime else { return nil }
                return SleepViewData(
                    id: id,
                    startTime: startTime,
                    duration: session.duration,
                    quality: Int(session.quality)
                )
            }
        } catch {
            errorMessage = "Erreur lors du chargement des données : \(error.localizedDescription)"
        }
    }
}
