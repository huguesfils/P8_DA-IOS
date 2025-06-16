import Foundation
import Testing
@testable import Arista

final class MockExerciseListRepository: ExerciseRepositoryInterface {
    var fetchExercisesResult: [ExerciseEntity] = []
    var fetchExercisesError: Error?
    var addExerciseCalled = false
    func fetchExercises() throws -> [ExerciseEntity] {
        if let error = fetchExercisesError { throw error }
        return fetchExercisesResult
    }
    func addExercise(type: String, duration: Int32, intensity: Int32, date: Date) throws {
        addExerciseCalled = true
    }
}

@MainActor
struct ExerciseListViewModelTests {
    @Test
    func testFetchExercisesSuccess() async throws {
        let entity = ExerciseEntity(context: PersistenceController.shared.container.viewContext)
        entity.id = UUID()
        entity.type = "Football"
        entity.duration = 60
        entity.intensity = 5
        entity.date = Date()
        let mockRepo = MockExerciseListRepository()
        mockRepo.fetchExercisesResult = [entity]
        let viewModel = ExerciseListViewModel(repository: mockRepo)
        viewModel.fetchExercises()
        #expect(viewModel.exercises.count == 1)
        #expect(viewModel.exercises.first?.type == "Football")
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func testFetchExercisesError() async throws {
        let mockRepo = MockExerciseListRepository()
        mockRepo.fetchExercisesError = NSError(domain: "Test", code: 1)
        let viewModel = ExerciseListViewModel(repository: mockRepo)
        viewModel.fetchExercises()
        #expect(viewModel.exercises.isEmpty)
        #expect(viewModel.errorMessage?.contains("Error loading data") == true)
    }
}
