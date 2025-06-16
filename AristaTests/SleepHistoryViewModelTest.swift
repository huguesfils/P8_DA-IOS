import Foundation
import Testing
@testable import Arista

final class MockSleepRepository: SleepRepositoryInterface {
    var sessionsToReturn: [SleepEntity] = []
    var shouldThrow = false
    func getSleepSessions() throws -> [SleepEntity] {
        if shouldThrow { throw NSError(domain: "Test", code: 1, userInfo: nil) }
        return sessionsToReturn
    }
}

@MainActor
struct SleepHistoryViewModelTest {
    @Test
    func testFetchSleepSessionsSuccess() async throws {
        let mockRepo = MockSleepRepository()
        let session = SleepEntity(context: PersistenceController.shared.container.viewContext)
        session.id = UUID()
        session.startTime = Date()
        session.duration = 480
        session.quality = 7
        mockRepo.sessionsToReturn = [session]
        let viewModel = SleepHistoryViewModel(repository: mockRepo)
        #expect(viewModel.sleepSessions.count == 1)
        #expect(viewModel.sleepSessions.first?.quality == 7)
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testFetchSleepSessionsError() async throws {
        let mockRepo = MockSleepRepository()
        mockRepo.shouldThrow = true
        let viewModel = SleepHistoryViewModel(repository: mockRepo)
        #expect(viewModel.sleepSessions.isEmpty)
        #expect(viewModel.errorMessage?.contains("Erreur lors du chargement des données") == true)
    }
}
