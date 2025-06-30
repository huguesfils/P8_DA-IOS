import Foundation
import Testing
@testable import Arista

@MainActor
struct SleepHistoryViewModelTest {
    @Test
    func testFetchSleepSessionsSuccess() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let session = SleepEntity(context: context)
        session.id = UUID()
        session.startTime = Date()
        session.duration = 480
        session.quality = 7
        try context.save()
        let repo = SleepRepository(viewContext: context)
        let viewModel = SleepHistoryViewModel(repository: repo)
        #expect(viewModel.sleepSessions.count == 1)
        #expect(viewModel.sleepSessions.first?.quality == 7)
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testFetchSleepSessionsError() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = SleepRepository(viewContext: context)
        let viewModel = SleepHistoryViewModel(repository: repo)
        #expect(viewModel.sleepSessions.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
}
