import Foundation
import Testing
@testable import Arista

@MainActor
struct AddExerciseViewModelTests {
    @Test
    func testAddExerciseSuccess() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = ExerciseRepository(viewContext: context)
        let viewModel = AddExerciseViewModel(repository: repo)
        viewModel.category = "Football"
        viewModel.duration = "45"
        viewModel.intensity = "5"
        viewModel.selectedTime = Date()
        let result = viewModel.addExercise()
        #expect(result == true)
        let fetch = try repo.fetchExercises()
        #expect(fetch.count == 1)
        #expect(fetch.first?.type == "Football")
        #expect(fetch.first?.duration == 45)
        #expect(fetch.first?.intensity == 5)
    }
    
    @Test
    func testAddExerciseInvalidFields() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = ExerciseRepository(viewContext: context)
        let viewModel = AddExerciseViewModel(repository: repo)
        viewModel.category = ""
        viewModel.duration = ""
        viewModel.intensity = ""
        let result = viewModel.addExercise()
        #expect(result == false)
        let fetch = try repo.fetchExercises()
        #expect(fetch.isEmpty)
        #expect(viewModel.errorMessage == "Veuillez remplir tous les champs correctement.")
    }
    
    @Test
    func testAddExerciseIntensityOutOfBounds() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = ExerciseRepository(viewContext: context)
        let viewModel = AddExerciseViewModel(repository: repo)
        viewModel.category = "Football"
        viewModel.duration = "30"
        viewModel.intensity = "15"
        let result = viewModel.addExercise()
        #expect(result == false)
        let fetch = try repo.fetchExercises()
        #expect(fetch.isEmpty)
        #expect(viewModel.errorMessage == "L'intensité doit être comprise entre 0 et 10.")
    }
    
    @Test
    func testIsFormValid() async throws {
        let container = CoreDataMock.makeInMemoryContainer()
        let context = container.viewContext
        let repo = ExerciseRepository(viewContext: context)
        let viewModel = AddExerciseViewModel(repository: repo)
        
        viewModel.category = "Football"
        viewModel.duration = "30"
        viewModel.intensity = "5"
        #expect(viewModel.isFormValid == true)
        
        viewModel.category = ""
        #expect(viewModel.isFormValid == false)
        
        viewModel.category = "Football"
        viewModel.duration = ""
        #expect(viewModel.isFormValid == false)
        
        viewModel.duration = "30"
        viewModel.intensity = ""
        #expect(viewModel.isFormValid == false)
        
        viewModel.intensity = "5"
        viewModel.duration = "abc"
        #expect(viewModel.isFormValid == false)
        
        viewModel.duration = "30"
        viewModel.intensity = "abc"
        #expect(viewModel.isFormValid == false)
    }
}
