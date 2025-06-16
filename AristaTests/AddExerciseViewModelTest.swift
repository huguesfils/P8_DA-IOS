import Foundation
import Testing
@testable import Arista

final class MockExerciseRepository: ExerciseRepositoryInterface {
    var addExerciseCalled = false
    var lastType: String?
    var lastDuration: Int32?
    var lastIntensity: Int32?
    var lastDate: Date?
    func fetchExercises() throws -> [ExerciseEntity] { [] }
    func addExercise(type: String, duration: Int32, intensity: Int32, date: Date) throws {
        addExerciseCalled = true
        lastType = type
        lastDuration = duration
        lastIntensity = intensity
        lastDate = date
    }
}

@MainActor
struct AddExerciseViewModelTests {
    @Test
    func testAddExerciseSuccess() async throws {
        let mockRepo = MockExerciseRepository()
        let viewModel = AddExerciseViewModel(repository: mockRepo)
        viewModel.category = "Football"
        viewModel.duration = "45"
        viewModel.intensity = "5"
        viewModel.selectedTime = Date()
        let result = viewModel.addExercise()
        #expect(result == true)
        #expect(mockRepo.addExerciseCalled == true)
        #expect(mockRepo.lastType == "Football")
        #expect(mockRepo.lastDuration == 45)
        #expect(mockRepo.lastIntensity == 5)
    }
    
    @Test
    func testAddExerciseInvalidFields() async throws {
        let mockRepo = MockExerciseRepository()
        let viewModel = AddExerciseViewModel(repository: mockRepo)
        viewModel.category = ""
        viewModel.duration = ""
        viewModel.intensity = ""
        let result = viewModel.addExercise()
        #expect(result == false)
        #expect(mockRepo.addExerciseCalled == false)
        #expect(viewModel.errorMessage == "Veuillez remplir tous les champs correctement.")
    }
    
    @Test
    func testAddExerciseIntensityOutOfBounds() async throws {
        let mockRepo = MockExerciseRepository()
        let viewModel = AddExerciseViewModel(repository: mockRepo)
        viewModel.category = "Football"
        viewModel.duration = "30"
        viewModel.intensity = "15"
        let result = viewModel.addExercise()
        #expect(result == false)
        #expect(mockRepo.addExerciseCalled == false)
        #expect(viewModel.errorMessage == "L'intensité doit être comprise entre 0 et 10.")
    }
}
