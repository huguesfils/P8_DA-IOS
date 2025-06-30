import Foundation
import Testing
@testable import Arista

@MainActor
struct ExerciseListViewModelTests {
    @Test
    func testFetchExercisesSuccess() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let entity = ExerciseEntity(context: context)
        entity.id = UUID()
        entity.type = "Football"
        entity.duration = 60
        entity.intensity = 5
        entity.date = Date()
        try context.save()
        let repo = ExerciseRepository(viewContext: context)
        let viewModel = ExerciseListViewModel(repository: repo)
        viewModel.fetchExercises()
        #expect(viewModel.exercises.count == 1)
        #expect(viewModel.exercises.first?.type == "Football")
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test
    func testFetchExercisesError() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = ExerciseRepository(viewContext: context)
        let viewModel = ExerciseListViewModel(repository: repo)
        viewModel.fetchExercises()
        #expect(viewModel.exercises.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }
}
